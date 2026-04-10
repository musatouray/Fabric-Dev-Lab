CREATE TABLE [dbo].[FactCurrencyRate] (

	[CurrencyKey] int NULL, 
	[DateKey] int NULL, 
	[AverageRate] float NULL, 
	[EndOfDayRate] float NULL, 
	[Date] datetime2(3) NULL
);