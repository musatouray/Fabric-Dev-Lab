# Copilot Instructions

## Build, test, and lint

This repository is a Microsoft Fabric / Power BI artifact repo, not a conventional application with a repo-wide npm, pytest, or lint workflow. Most changes are validated in Power BI Desktop, the Fabric workspace, Spark notebooks, or the Fabric SQL endpoint.

SQL warehouse projects are SDK-style `.sqlproj` files that can be schema-built with `dotnet build` when compatible SQL build tooling is available:

```powershell
dotnet build "fabric_artifacts\SQL Customer RFM Analytics\sales_warehouse.Warehouse\sales_warehouse.sqlproj"
dotnet build "fabric_artifacts\people analytics\people_analytics_warehouse.Warehouse\people_analytics_warehouse.sqlproj"
dotnet build "fabric_artifacts\plotly\plotly_warehouse.Warehouse\plotly_warehouse.sqlproj"
```

There is no automated test suite in the repo, so there is no single-test command to run.

## High-level architecture

The repo is a Fabric monorepo with three main artifact stacks under `fabric_artifacts`:

1. **SQL Customer RFM Analytics**: a full warehouse + semantic model + report chain. `sales_warehouse.Warehouse` contains SQL table/view definitions, `RFM Analysis Model.SemanticModel` defines the tabular model in TMDL, and `RFM Analysis Report.pbip` / `RFM Analysis Report.Report` bind the report to the semantic model in the Fabric workspace. Report-level measures such as SVG and HTML KPI cards live in `RFM Analysis Report.Report\definition\reportExtensions.json`, while reusable DAX functions live in `RFM Analysis Model.SemanticModel\definition\functions.tmdl`.
2. **people analytics**: a Fabric notebook pipeline. `download Kaggle dataset.Notebook` pulls credentials from the shared variable library, downloads the CSV into Lakehouse files, and `01_bronze_ingest.Notebook` reads that file, normalizes columns, adds ingestion metadata, and writes the `bronze_hr_attrition` Delta table in `people_analytics_lakehouse`. `people_analytics_warehouse.Warehouse` is the downstream SQL warehouse project for modeled data.
3. **plotly**: a warehouse + semantic model pair for taxi/transport analytics. `plotly_warehouse.Warehouse` holds the SQL definitions, and `plotly semantic model.SemanticModel` is a thin TMDL projection over the warehouse tables (`Date`, `Time`, `Geography`, `HackneyLicense`, `Medallion`, `Trip`, `Weather`).

Across the repo, semantic model tables and relationships are tightly coupled to warehouse object names. The RFM report also contains an explicit Fabric workspace connection string in `RFM Analysis Report.Report\definition.pbir`, so moving or renaming model/report artifacts requires updating both sides of that wiring.

Semantic model work usually spans multiple files, not just one table definition. `definition\database.tmdl` and `definition\model.tmdl` hold model-wide settings such as compatibility level, DirectLake query order, and the list of referenced tables; table-level files under `definition\tables\` hold columns and measures; and `relationships.tmdl`, `expressions.tmdl`, and `functions.tmdl` capture cross-table wiring, shared expressions, and reusable DAX functions. Changes that add or rename model objects often need coordinated edits across those files.

PBIP report work is also split across artifacts. The `.pbip` file points to the report folder, `definition.pbir` stores the semantic-model connection, `definition\pages\pages.json` controls page order and the active page, each page has its own `page.json`, and visuals live in GUID-named folders under each page's `visuals\` directory. Static backgrounds and image assets are referenced through `StaticResources\RegisteredResources`, so page background changes can require both page JSON and registered resource updates.

## Key conventions

- Treat `.pbip`, `.Report`, `.SemanticModel`, `.Notebook`, `.Warehouse`, `.Lakehouse`, `.CopyJob`, and `.VariableLibrary` contents as source-controlled Fabric artifacts. Preserve their JSON/TMDL metadata structure rather than rewriting files into ad hoc formats.
- Warehouse and model naming follows dimensional-model conventions: dimensions use `Dim*`, facts use `Fact*`, and semantic model/table names intentionally mirror warehouse objects.
- Scope semantic-model edits carefully: model-wide settings belong in `database.tmdl` / `model.tmdl`, table definitions belong under `definition\tables\`, and joins belong in `relationships.tmdl`. Do not move table-level logic into the wrong file just because a single edit seems local.
- DAX measures are organized into virtual measure tables such as `Metrics` and `Pages`. Keep related measures in those tables and preserve the existing `displayFolder` taxonomy because the field list structure is part of the model UX.
- In the RFM project, prefer the reusable helper library in `RFM Analysis Model.SemanticModel\definition\functions.tmdl` (especially `SVG.KpiCard`) over duplicating large inline SVG expressions. SVG measures must keep `dataCategory: ImageUrl`, and SVG color literals inside data URIs must encode `#` as `%23`.
- For “bad when increasing” KPIs such as churn, the RFM card pattern uses `invertColors = TRUE` when calling `SVG.KpiCard`.
- Scope PBIP report edits to the correct layer: use `definition.pbir` for dataset wiring, `pages.json` for navigation/order, `page.json` for page-level properties like size/background, and per-visual `visual.json` files for visual configuration. Preserve GUID-based folder names and existing resource references instead of renaming folders casually.
- The people analytics notebooks use the shared variable library `vl_fabricdevlab` with `notebookutils.variableLibrary` and `notebookutils.credentials` to resolve Key Vault-backed secrets. Do not hardcode secrets into notebooks or variable-library files.
- The bronze ingest notebook normalizes incoming columns to lowercase `snake_case` and adds `_ingested_at`. Preserve that pattern in downstream ingestion notebooks so SQL and Delta schemas stay predictable.
- The bronze ingest write path is intentionally idempotent: it overwrites the `bronze_hr_attrition` Delta table and updates schema on write.
