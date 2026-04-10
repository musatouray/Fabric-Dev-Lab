CREATE TABLE [dbo].[NewFactCurrencyRate] (

	[AverageRate] real NULL, 
	[CurrencyID] varchar(8000) NULL, 
	[CurrencyDate] date NULL, 
	[EndOfDayRate] real NULL, 
	[CurrencyKey] int NULL, 
	[DateKey] int NULL
);