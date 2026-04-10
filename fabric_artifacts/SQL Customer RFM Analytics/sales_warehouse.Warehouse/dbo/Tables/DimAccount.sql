CREATE TABLE [dbo].[DimAccount] (

	[AccountKey] int NULL, 
	[ParentAccountKey] int NULL, 
	[AccountCodeAlternateKey] int NULL, 
	[ParentAccountCodeAlternateKey] int NULL, 
	[AccountDescription] varchar(8000) NULL, 
	[AccountType] varchar(8000) NULL, 
	[Operator] varchar(8000) NULL, 
	[CustomMembers] varchar(8000) NULL, 
	[ValueType] varchar(8000) NULL, 
	[CustomMemberOptions] varchar(8000) NULL
);