CREATE TABLE [dbo].[FactCallCenter] (

	[FactCallCenterID] int NULL, 
	[DateKey] int NULL, 
	[WageType] varchar(8000) NULL, 
	[Shift] varchar(8000) NULL, 
	[LevelOneOperators] smallint NULL, 
	[LevelTwoOperators] smallint NULL, 
	[TotalOperators] smallint NULL, 
	[Calls] int NULL, 
	[AutomaticResponses] int NULL, 
	[Orders] int NULL, 
	[IssuesRaised] smallint NULL, 
	[AverageTimePerIssue] smallint NULL, 
	[ServiceGrade] float NULL, 
	[Date] datetime2(3) NULL
);