/*
  1. Define Variable
  2. Create a CTE that rounds the total likes per influencer
  3. Select the columns that are required for the analysis
  4. fliter the result by the tiktokers influencer with the highest followers bases
  5. Order by net_profit (from highest to lowest)
  */

   -- 1. Define Variable
  Declare @conversionRate FLOAT = 0.02;		-- Conversion Rate @ 2%
  Declare @ProductCost MONEY = 5.0;			-- Product Rate @ $5
  Declare @CampaignCost MONEY = 50000.0;		-- Campaign Cost @ 50,000

-- 2. Create a CTE that rounds the total likes per influence
WITH CTE_Tiktokers AS (
  SELECT 
    Username,
    total_followers,
	total_likes,
	ROUND((CAST(total_likes AS FLOAT) / total_uploads), -4) AS rounded_avg_likes_uploads,
    total_uploads
  FROM 
    view_tiktokers_2025
)

-- 3. Select the columns that are required for the analysis

SELECT 
  Username,
  	total_likes,
	rounded_avg_likes_uploads,
  (	rounded_avg_likes_uploads * @conversionRate) AS potential_unit_sold_of_influencer_likes,
  (rounded_avg_likes_uploads * @conversionRate * @ProductCost) AS potential_revenue_of_influencer_likes,
  (rounded_avg_likes_uploads * @conversionRate * @ProductCost) - @CampaignCost AS net_profit
FROM 
  CTE_Tiktokers



-- 4. fliter the result by the tiktokers influencer with the highest followers bases

	WHERE Username IN ('Charli d''amelio', 'Barstool Sports', 'ESPN')

	
-- 5. Order by net_profit (from highest to lowest)
	ORDER BY 
		net_profit DESC

