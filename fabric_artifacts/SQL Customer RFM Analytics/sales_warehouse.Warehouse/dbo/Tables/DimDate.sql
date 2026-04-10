CREATE TABLE [dbo].[DimDate] (

	[DateKey] int NULL, 
	[FullDateAlternateKey] date NULL, 
	[DayNumberOfWeek] int NULL, 
	[EnglishDayNameOfWeek] varchar(8000) NULL, 
	[DayNumberOfMonth] int NULL, 
	[DayNumberOfYear] smallint NULL, 
	[WeekNumberOfYear] int NULL, 
	[EnglishMonthName] varchar(8000) NULL, 
	[MonthNumberOfYear] int NULL, 
	[CalendarQuarter] int NULL, 
	[CalendarYear] smallint NULL, 
	[CalendarSemester] int NULL, 
	[FiscalQuarter] int NULL, 
	[FiscalYear] smallint NULL, 
	[FiscalSemester] int NULL, 
	[MonthInitial] char(1) NULL, 
	[MonthInitialIndex] int NULL
);