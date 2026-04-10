CREATE TABLE [dbo].[DimOrganization] (

	[OrganizationKey] int NULL, 
	[ParentOrganizationKey] int NULL, 
	[PercentageOfOwnership] varchar(8000) NULL, 
	[OrganizationName] varchar(8000) NULL, 
	[CurrencyKey] int NULL
);