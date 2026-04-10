CREATE TABLE [dbo].[DimGeography] (

	[GeographyKey] int NULL, 
	[City] varchar(8000) NULL, 
	[StateProvinceCode] varchar(8000) NULL, 
	[StateProvinceName] varchar(8000) NULL, 
	[CountryRegionCode] varchar(8000) NULL, 
	[EnglishCountryRegionName] varchar(8000) NULL, 
	[SpanishCountryRegionName] varchar(8000) NULL, 
	[FrenchCountryRegionName] varchar(8000) NULL, 
	[PostalCode] varchar(8000) NULL, 
	[SalesTerritoryKey] int NULL, 
	[IpAddressLocator] varchar(8000) NULL
);