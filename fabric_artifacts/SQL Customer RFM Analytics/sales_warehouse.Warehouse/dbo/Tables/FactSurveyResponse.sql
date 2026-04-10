CREATE TABLE [dbo].[FactSurveyResponse] (

	[SurveyResponseKey] int NULL, 
	[DateKey] int NULL, 
	[CustomerKey] int NULL, 
	[ProductCategoryKey] int NULL, 
	[EnglishProductCategoryName] varchar(8000) NULL, 
	[ProductSubcategoryKey] int NULL, 
	[EnglishProductSubcategoryName] varchar(8000) NULL, 
	[Date] datetime2(3) NULL
);