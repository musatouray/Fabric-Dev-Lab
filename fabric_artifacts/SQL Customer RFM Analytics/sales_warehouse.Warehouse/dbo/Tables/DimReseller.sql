CREATE TABLE [dbo].[DimReseller] (

	[ResellerKey] int NULL, 
	[GeographyKey] int NULL, 
	[ResellerAlternateKey] varchar(8000) NULL, 
	[Phone] varchar(8000) NULL, 
	[BusinessType] varchar(20) NULL, 
	[ResellerName] varchar(8000) NULL, 
	[NumberEmployees] int NULL, 
	[OrderFrequency] char(1) NULL, 
	[OrderMonth] int NULL, 
	[FirstOrderYear] int NULL, 
	[LastOrderYear] int NULL, 
	[ProductLine] varchar(8000) NULL, 
	[AddressLine1] varchar(8000) NULL, 
	[AddressLine2] varchar(8000) NULL, 
	[AnnualSales] decimal(19,4) NULL, 
	[BankName] varchar(8000) NULL, 
	[MinPaymentType] int NULL, 
	[MinPaymentAmount] decimal(19,4) NULL, 
	[AnnualRevenue] decimal(19,4) NULL, 
	[YearOpened] int NULL
);