CREATE TABLE [dbo].[FactCustomerRFM] (

	[CustomerKey] int NULL, 
	[FullName] varchar(8000) NOT NULL, 
	[LastOrderDate] date NULL, 
	[Recency] int NULL, 
	[Frequency] int NULL, 
	[Monetary] decimal(38,4) NULL, 
	[TotalCost] decimal(38,4) NULL, 
	[Recency_Score] bigint NULL, 
	[Frequency_Score] bigint NULL, 
	[Monetary_Score] bigint NULL, 
	[Profit] decimal(38,4) NULL, 
	[ProfitMarginPercent] decimal(38,6) NULL, 
	[Segment] varchar(27) NOT NULL, 
	[SegmentIndex] int NOT NULL
);