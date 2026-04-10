CREATE TABLE [dbo].[FactSalesQuota] (

	[SalesQuotaKey] int NULL, 
	[EmployeeKey] int NULL, 
	[DateKey] int NULL, 
	[CalendarYear] smallint NULL, 
	[CalendarQuarter] int NULL, 
	[SalesAmountQuota] decimal(19,4) NULL, 
	[Date] datetime2(3) NULL
);