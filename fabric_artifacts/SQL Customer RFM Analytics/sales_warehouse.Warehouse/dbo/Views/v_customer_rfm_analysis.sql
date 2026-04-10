-- Auto Generated (Do not modify) AB21A613C709ECAD5E5739C14D4090A49DC45BA3844A7B8B67FADEADF281A2F1
/*
    RFM (Recency, Frequency, Monetary) - Analysis is a customer segmentation analysis pattern that allows
    to rank and group customers based on thier purchasing behaviours.
    It helps marketing to identify who their best customers are and 
    which ones are at risk of churning.
    Recency (R): How long since the customer's last order. The lesser the better. Identifies less likely churners
    Frequency (F): How often the customer orders. The higher the better. Identifies the loyal ones.
    Monetary (M): Total customer order value. The higher the better. Identifies the big spenders.

*/

CREATE   VIEW dbo.v_customer_rfm_analysis AS
-- Step 1: Calculate precise financial metrics
-- Join early to get names for the final output
WITH rfm_metrics AS (
    SELECT 
        c.CustomerKey,
        CONCAT_WS(' ', c.FirstName, c.MiddleName, c.LastName) AS FullName,
        -- last order date
        MAX(CAST(int.OrderDate AS DATE)) AS LastOrderDate,
        -- Recency: days since last order relative to a fixed "Current Date"
        DATEDIFF(DAY, MAX(int.OrderDate), '2014-01-31') AS Recency,
        -- Frequency: count unique orders only
        COUNT(DISTINCT SalesOrderNumber) AS Frequency,
        -- Monetary: Gross Revenue including Tax and Freight
        SUM(int.SalesAmount + int.TaxAmt + int.Freight) AS Monetary,
        -- Total cost
        SUM(int.TotalProductCost) AS TotalCost
    FROM dbo.FactInternetSales int
    JOIN dbo.DimCustomer c ON int.CustomerKey = c.CustomerKey
    GROUP BY 
        c.CustomerKey, 
        CONCAT_WS(' ', c.FirstName, c.MiddleName, c.LastName)
),

-- Step 2: Robust Statistical scoring
-- We use NTILE from 5 to 1 (best=5, worst=1) directly to the metrics to ensure exactly 20% of Customers.
rfm_scoring AS (
    SELECT 
        *,
        NTILE(5) OVER ( ORDER BY Recency ASC ) AS Recency_Score,
        NTILE(5) OVER ( ORDER BY Frequency ASC ) AS Frequency_Score,
        NTILE(5) OVER ( ORDER BY Monetary ASC ) AS Monetary_Score
    FROM rfm_metrics
),

-- Step 3: Calculate Business KPIs and Cell-Based Logic
customer_segmentation AS (
    SELECT
        *,
        CONCAT(Recency_Score, Frequency_Score, Monetary_Score) AS RFM_Cell,
        Monetary / NULLIF(Frequency, 0) AS AverageOrderValue,
        Monetary - TotalCost AS Profit,
        ((Monetary - TotalCost) / NULLIF(Monetary, 0)) * 100 AS ProfitMarginPercent
    FROM rfm_scoring
)

-- Step 4: Final output with categorical segmentation
SELECT 
    CustomerKey, 
    FullName,
    LastOrderDate,
    Recency,
    Frequency,
    ROUND(Monetary, 2) AS Monetary,
    ROUND(TotalCost, 2) TotalCost,
    Recency_Score,
    Frequency_Score,
    Monetary_Score,
    ROUND(Profit, 2) AS Profit,
    ROUND(ProfitMarginPercent, 2) AS ProfitMarginPercent,
    CASE 
        WHEN RFM_Cell = '555' THEN 'Champions'
        WHEN Recency_Score >= 4 AND Frequency_Score >= 4 THEN 'Loyalists'
        WHEN Recency_Score >= 4 AND Frequency_Score = 1 THEN 'New Customers'
        WHEN Recency_Score <= 2 AND Frequency_Score >= 4 THEN 'At Risk - Can''t Lose'
        WHEN Recency_Score <= 2 AND Frequency_Score <= 2 THEN 'Lost / Inactive'
        ELSE 'Potential / Needs Attention'
    END AS Segment,
    CASE 
        WHEN RFM_Cell = '555' THEN 1
        WHEN Recency_Score >= 4 AND Frequency_Score >= 4 THEN 2
        WHEN Recency_Score >= 4 AND Frequency_Score = 1 THEN 3
        WHEN Recency_Score <= 2 AND Frequency_Score >= 4 THEN 4
        WHEN Recency_Score <= 2 AND Frequency_Score <= 2 THEN 5
        ELSE 6
    END AS SegmentIndex
FROM customer_segmentation;