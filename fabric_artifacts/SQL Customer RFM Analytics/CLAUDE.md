# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Microsoft Power BI Fabric project** for Customer RFM (Recency, Frequency, Monetary) Analysis. It uses the PBIP (Power BI Project) format, which stores Power BI artifacts as JSON files for version control.

**Key Technologies:** DAX (Data Analysis Expressions), TMDL (Tabular Model Definition Language), Power BI Fabric

## Project Structure

```
Customer RFM Analysis.pbip          # Project manifest (entry point)
Customer RFM Analysis.Report/       # Report artifact
├── definition.pbir                 # Semantic model connection config
├── definition/
│   ├── report.json                 # Report settings & theme
│   ├── reportExtensions.json       # Report-level DAX measures
│   └── pages/                      # Report pages (GUID-named folders)
└── StaticResources/                # SVG/PNG icons

functions.tmdl                      # Reusable DAX functions (SVG library)
SVG_RFM_Monthly_Card.dax            # Standalone DAX measure example
SVG_Card_Template.dax               # Template for creating new SVG cards
images/                             # Dashboard graphics
```

## Data Model

Star schema with semantic model "RFM Analysis Model" hosted in Fabric workspace "Fabric Dev Lab":

- **Fact Table:** `FactCustomerRFM` (RFM segments: Champions, VIPs, Loyalists, At Risk)
- **Dimension Tables:** `DimCustomer`, `DimDate`, `DimEmployee`, `DimGeography`, `DimProduct`, `DimProductCategory`
- **Calculation Table:** `Metrics` (SVG card measures, color coding)

## Working with DAX

### SVG KPI Cards

This project uses DAX to generate SVG data-URI images for KPI cards (360×260px) with sparklines. Two approaches exist:

1. **`functions.tmdl`** - Reusable TMDL function library following DaxLib.SVG patterns:
   - `SVG.KpiCard()` - High-level function that generates complete cards
   - `SVG.Element.*` - Low-level SVG element builders (Rect, Txt, Line)
   - `SVG.Attr.*` - Attribute generators (Shapes, Txt, Stroke)
   - `SVG.Color.*` - Color encoding utilities

2. **`SVG_Card_Template.dax`** - Copy-paste template for inline measures (modify 3 vars: `_title`, `_measure`, `_format`)

### Adding New SVG Card Measures

Using the function library (preferred):
```dax
SVG Card MyMetric =
SVG.KpiCard([My Measure], "Title", "$#,##0", FALSE, DimDate[FullDateAlternateKey], DimDate[MonthNumberOfYear])
```

For negative KPIs (where increase is bad, like churn), set the `invertColors` parameter to `TRUE`.

**Important:** After adding DAX measures to Power BI Desktop, set Data category to "Image URL" in the Properties pane.

## Key Files

- **`reportExtensions.json`** - Contains report-level measures in the `Metrics` entity (SVG cards, segment colors)
- **`definition.pbir`** - Semantic model connection string (ReadOnly, ClaimsToken auth)

## Development Notes

- No traditional build/test commands - use Power BI Desktop or Fabric workspace
- Report pages are stored in GUID-named folders under `definition/pages/`
- Local settings (`.pbi/localSettings.json`, `.pbi/cache.abf`) are gitignored
- Theme: Microsoft Fluent 2 (CY26SU03)
- Display: 1920×1080 with FitToPage layout

## Color Conventions in DAX

URL-encoded hex colors for SVG data-URIs (`%23` encodes `#`):

| Color | Hex | Usage |
|-------|-----|-------|
| Green | `%2316a34a` | Positive change |
| Red | `%23dc2626` | Negative change |
| Gray | `%23999999` | No prior year data |
| Light blue | `%2393c5fd` | Normal sparkline bar |
| Dark navy | `%231e3a8a` | Highlighted (current month) bar |
| Border blue | `%233b82f6` | Card border |

## RFM Segment Colors

Used in `Color Selected Segment` measure:
- Champions: `#BAC5BD`
- VIPs: `#CEC5B9`
- Loyalists: `#BDC3CE`
- At Risk: `#C6ABB4`

## Power BI Skills Library

Extended Power BI development skills are available at:
`../power-bi-agentic-development/plugins/`

| Plugin | Use For |
|--------|---------|
| `pbip` | PBIP project structure, PBIX extraction, rename cascades |
| `tmdl` | Direct TMDL file editing, measure/column definitions |
| `pbir-format` | PBIR JSON format, visual.json, themes, filters |
| `reports` | Deneb, R/Python visuals, SVG visuals, themes |
| `semantic-models` | DAX patterns, Power Query, naming conventions |
| `fabric-cli` | Fabric CLI operations for remote deployment |

To load a skill, read its `SKILL.md` file (e.g., `../power-bi-agentic-development/plugins/pbip/skills/pbip/SKILL.md`).
