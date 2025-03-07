/*
  1. Define Variable
  2. Create a CTE that rounds the average views per videos 
  3. Select the columns that are required for the analysis
  4. fliter the result by the tiktokers influencer with the highest followers bases
  5. Order by net_profit (from highest to lowest)
  */

  -- 1. Define Variable
  Declare @conversionRate FLOAT = 0.02;		-- Conversion Rate @ 2%
  Declare @ProductCost MONEY = 5.0;			-- Product Rate @ $5
  Declare @CampaignCost MONEY = 50000.0;		-- Campaign Cost @ 50,000

  --2. Create a CTE that rounds the average views per videos 
  WITH InfluencerName AS (
  SELECT Username,
		total_followers,
		total_uploads,
		total_likes,
		ROUND((CAST(total_likes AS FLOAT) / total_uploads), -4) AS rounded_avg_likes_uploads
	FROM 
		dbo.view_tiktokers_2025
	)

-- 3. Select the columns that are required for the analysis
SELECT 
Username,
rounded_avg_likes_uploads,
(rounded_avg_likes_uploads * @conversionRate) AS potential_unit_sold_per_upload,
(rounded_avg_likes_uploads * @conversionRate * @ProductCost) AS potential_revenue_per_upload,
(rounded_avg_likes_uploads * @conversionRate * @ProductCost) - @CampaignCost as net_profit
FROM InfluencerName


-- 4. fliter by tiktokers influencers 
WHERE Username IN ('Jason Derulo', 'Carlos Feria', 'Khabane lame') 


-- 5. Order by net_profit (from highest to lowest)
ORDER BY 
net_profit DESC
	