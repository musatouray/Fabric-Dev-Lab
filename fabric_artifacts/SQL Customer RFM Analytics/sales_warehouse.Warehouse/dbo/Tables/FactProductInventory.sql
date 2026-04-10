CREATE TABLE [dbo].[FactProductInventory] (

	[ProductKey] int NULL, 
	[DateKey] int NULL, 
	[MovementDate] date NULL, 
	[UnitCost] decimal(19,4) NULL, 
	[UnitsIn] int NULL, 
	[UnitsOut] int NULL, 
	[UnitsBalance] int NULL
);