CREATE TABLE [dbo].[DimPromotion] (

	[PromotionKey] int NULL, 
	[PromotionAlternateKey] int NULL, 
	[EnglishPromotionName] varchar(8000) NULL, 
	[SpanishPromotionName] varchar(8000) NULL, 
	[FrenchPromotionName] varchar(8000) NULL, 
	[DiscountPct] float NULL, 
	[EnglishPromotionType] varchar(8000) NULL, 
	[SpanishPromotionType] varchar(8000) NULL, 
	[FrenchPromotionType] varchar(8000) NULL, 
	[EnglishPromotionCategory] varchar(8000) NULL, 
	[SpanishPromotionCategory] varchar(8000) NULL, 
	[FrenchPromotionCategory] varchar(8000) NULL, 
	[StartDate] datetime2(3) NULL, 
	[EndDate] datetime2(3) NULL, 
	[MinQty] int NULL, 
	[MaxQty] int NULL
);