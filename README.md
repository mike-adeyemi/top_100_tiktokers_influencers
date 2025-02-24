# Data Portfolio: Excel to Power BI


# Table of contents

- [Objective](Objective)
- [Data Source](DataSource)
- [Stages](Stages)
- [Design](Design)
  - [Mockup](Mockup)
  - [Tools](Tools)
- [Development](Development)
  - [Pseudocode](Pseudocode)
  - [Data Exploration](DataExploration)
  - [Data Cleaning](DataCleaning)
  - [Transform the Data](TransformtheData)
  - [Create the SQL View](CreatetheSQLView)
- [Testing](Testing)
  - [Data Quality Tests](DataQualityTests)
- [Visualization](Visualization)
  - [Results](Results)
  - [DAX Measures](DAXMeasures)
- [Analysis](Analysis)
  - [Findings](Findings)
  - [Validation](Validation)
  - [Discovery](Discovery)
-[Recommendations](Recommendations)
  - [Potential ROI](PotentialROI)
  - [Potential Courses of Actions](PotentialCoursesofActions)
- [Conclusion](Conclusion)

# Objective

#### Key Pain Point?

The marketing team struggles to identify high-impact TikTok influencers due to inconsistent insights and an overwhelming amount of data.

-  What is the ideal solution?
  
To develop a data-driven dashboard that ranks top-performing TikTok influencers and provides actionable insights for optimizing marketing collaborations and campaign effectiveness.


To create a dashboard that provides insights into the top UK YouTubers in 2024 that includes their

The dashboard should display the top TikTok influencers, ranked based on:

- Followers count - Total number of followers
- Total uploads - The overall number of uploads
- Average likes per upload - The Average number of likes receives per upload.
- Engagement rate - Measured by the ratio of likes to followers.


The data-driven approach will enable the marketing team to make informed decisions when selecting Tiktok influencers for their campaign

## User story

As a Head of Marketing, I need a comprehensive ranking of top TikTok influencers based on key performance metrics to strategically select partners for brand campaigns.



The dashboard should enable the identification of top-performing TikTok influencers based on key metrics, including:

- Total Followers – The number of followers an influencer has.
- Total Uploads – The overall number of uploads.
- Average Likes per Upload – The average number of likes received per upload.
- Engagement Rate – Measured by the ratio of likes to followers.


This data-driven approach will help the marketing team strategically select influencers for brand campaigns and optimize marketing collaborations.



# Data source

- What data is needed to achieve our objective?

We need data on the top UK YouTubers in 2024 that includes their

- channel names

- total subscribers

- total views

- total videos uploaded

- Where is the data coming from? The data is sourced from Kaggle (an Excel extract), see here to find it.

# Stages

- Design
- Developement
- Testing
- Analysis

# Design

## Dashboard components required

- What should the dashboard contain based on the requirements provided?

To understand what it should contain, we need to figure out what questions we need the dashboard to answer:

1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

For now, these are some of the questions we need to answer, this may change as we progress down our analysis.

## Dashboard mockup

- What should it look like?

Some of the data visuals that may be appropriate in answering our questions include:

1. Table
2. Treemap
3. Scorecards
4. Horizontal bar chart

![dashboard mockup](https://github.com/user-attachments/assets/37b7bc31-32e3-4fad-993b-a4d9e25bb666)


## Tools

|Tool|	Purpose|
|----|---------|
|Excel	|Exploring the data|
|SQL Server|	Cleaning, testing, and analyzing the data|
|Power BI|	Visualizing the data via interactive dashboards|
|GitHub|	Hosting the project documentation and version control|
|Mokkup AI|	Designing the wireframe/mockup of the dashboard|

# Development

## Pseudocode

- What's the general approach in creating this solution from start to finish?

1. Get the data
2. Explore the data in Excel
3. Load the data into SQL Server
4. Clean the data with SQL
5. Test the data with SQL
6. Visualize the data in Power BI
7. Generate the findings based on the insights
8. Write the documentation + commentary
9. Publish the data to GitHub Pages

## Data exploration notes

This is the stage where you have a scan of what's in the data, errors, inconcsistencies, bugs, weird and corrupted characters etc

- What are your initial observations with this dataset? What's caught your attention so far?

1. There are at least 4 columns that contain the data we need for this analysis, which signals we have everything we need from the file without needing to contact the client for any more data.
2. The first column contains the channel ID with what appears to be channel IDS, which are separated by a @ symbol - we need to extract the channel names from this.
3. Some of the cells and header names are in a different language - we need to confirm if these columns are needed, and if so, we need to address them.
4. We have more data than we need, so some of these columns would need to be removed

## Data cleaning

- What do we expect the clean data to look like? (What should it contain? What contraints should we apply to it?)

The aim is to refine our dataset to ensure it is structured and ready for analysis.

The cleaned data should meet the following criteria and constraints:

- Only relevant columns should be retained.
- All data types should be appropriate for the contents of each column.
- No column should contain null values, indicating complete data for all records.

Below is a table outlining the constraints on our cleaned dataset:

|Property	|Description|
|--------|----------|
|Number of Rows|	100|
|Number of Columns	|4|

And here is a tabular representation of the expected schema for the clean data:

|Column Name	|Data Type	|Nullable|
|------------|-----------|---------|
|channel_name|	VARCHAR|	NO|
|total_subscribers|	INTEGER|	NO|
|total_views	|INTEGER|	NO|
|total_videos|	INTEGER	|NO|

- What steps are needed to clean and shape the data into the desired format?

1. Remove unnecessary columns by only selecting the ones you need
2. Extract Youtube channel names from the first column
3. Rename columns using aliases

### Transform the data

```sql
/*
# Cleaning step
1. Remove the unneccessary columns by selecting the one we need					
2. Extract the unneccssary characters from the username column (?)				
3. Rename all column username to Upper e.g MrBeast, dixie to Dixie only!!!	
*/

--		1.Remove the unneccessary columns by selecting the one we need
SELECT 
     Username,
     total_followers,
     total_following,
     total_uploads,
     total_likes
FROM 
    top_100_tiktokers_2025;

```


### Create the SQL view

```sql
/*
# Cleaning step

1. Remove the unneccessary columns by selecting the one we need					
2. Extract the unneccssary characters from the username column (?)				
3. Rename all column username to Upper e.g MrBeast, dixie to Dixie only!!!		
*/
--	How to create view that will load into power bi

CREATE VIEW view_tiktokers_2025 AS
SELECT 
     Username,
     total_followers,
     total_following,
     total_uploads,
     total_likes
FROM 
     top_100_tiktokers_2025;


# Cleaning step
-- 2. Extract the unneccssary characters from the username column (?)

-- Preview query before Updating the column
SELECT
     Username,
LTRIM(RTRIM(REPLACE(REPLACE(Username,'?', ''), ' ', ' ')))
AS
   Cleaned_Username 
FROM
   top_100_tiktokers_2025
WHERE
   Username LIKE '%?%';

--	Update the column Username to remove all spacing left, right and removed it from where ? is replaced with space
UPDATE
     top_100_tiktokers_2025
SET
  Username = 
LTRIM(RTRIM(REPLACE(REPLACE(Username, '?', ''), ' ', ' ')));

```

# Testing
- What data quality and validation checks are you going to create?
Here are the data quality tests conducted:

## Row count check

```sql
/*
1. Count the total number of records (or rows) are in the SQL view		
*/

SELECT 
    COUNT(*)
as 
 no_of_rows
FROM 
   view_tiktokers_2025;

```
![row_count_check](https://github.com/user-attachments/assets/5d80bded-4881-45bd-aee7-83c9ff9a8a0b)

## Column count check

### SQL query

```sql
/*
2. Count the total number of columns (or fields) are in the SQL view	
*/

SELECT 
   COUNT(*)
as column_count
FROM 
   INFORMATION_SCHEMA.COLUMNS
WHERE 
   TABLE_NAME = 'view_tiktokers_2025';

```

![column_count_test](https://github.com/user-attachments/assets/933e12d0-07d5-4d2e-a00f-ff99021e433f)

## Data type check

### SQL query
```sql
/*
The username column must be in string format and others columns must be numerical data types (data types check)
*/

-- 3. Data types check

SELECT 
COLUMN_NAME,
DATA_TYPE 
FROM 
   INFORMATION_SCHEMA.COLUMNS
WHERE 
   TABLE_NAME = 'view_tiktokers_2025';

```

### Output
![data_type_check](https://github.com/user-attachments/assets/9b16c8c3-f96f-4306-8933-f738a3f5b530)

## Duplicate count check

### SQL query
```sql
/*

# Data Quality tests

4. Each records must be unique in the dataset (duplicate count check)

*/

--		4. Duplicate records count 
SELECT Username,
COUNT(*) as duplicate_count
FROM 
  view_tiktokers_2025
GROUP BYUsername
HAVING COUNT(*) > 1;

```

### Output
![duplicate_count_check](https://github.com/user-attachments/assets/c16c8ee7-b148-41d0-bfaa-27e04c3fb19a)

# Visualization

## Results
- What does the dashboard look like?

https://github.com/user-attachments/assets/2ee2752f-a72d-467c-8f79-dafa962d3213

This shows the Top UK Youtubers in 2024 so far.

# DAX Measures

### 1. Total Subscribers (M)

```sql

Total Followers (M) = 
VAR million = 1000000
VAR sumOfFollowers = SUM(view_tiktokers_2025[total_followers])
VAR totalFollowers = DIVIDE(sumOfFollowers,million)

RETURN totalFollowers
````
### 2. Total Likes (B)
```sql
Total Likes (B) = 
VAR billion = 1000000000
VAR sumOfTotalLikes = SUM(view_tiktokers_2025[total_likes])
VAR totalLikes = ROUND(sumOfTotalLikes / billion, 2)

RETURN totalLikes
```
### Total Uploads
```sql
Total Uploads = 
VAR totalUploads = SUM(view_tiktokers_2025[total_uploads])

RETURN totalUploads
```
#### Average Likes per Upload (M)
```sql
Average Likes per Upload (M) = 
VAR sumOfTotalLikes = SUM(view_tiktokers_2025[total_likes])
VAR sumOfTotalUploads = SUM(view_tiktokers_2025[total_uploads])
VAR  avgLikesPerUpload = DIVIDE(sumOfTotalLikes,sumOfTotalUploads, BLANK())
VAR finalAvgLikesPerUpload = DIVIDE(avgLikesPerUpload, 1000000, BLANK())

RETURN finalAvgLikesPerUpload
```
#### Followers Engagement Rate
```sql
Followers Engagement Rate = 
VAR sumOfTotalFollowers = SUM(view_tiktokers_2025[total_followers])
VAR sumOfTotalUploads = SUM(view_tiktokers_2025[total_uploads])
VAR followersEngRate = DIVIDE(sumOfTotalFollowers, sumOfTotalUploads, BLANK())

RETURN followersEngRate
```
#### Likes Per Follower
```sql
Likes Per Follower = 
VAR sumOfTotalLikes = SUM(view_tiktokers_2025[total_likes])
VAR sumOfTotalFollowers = SUM(view_tiktokers_2025[total_followers])
VAR likePerFollower = DIVIDE(sumOfTotalLikes, sumOfTotalFollowers, BLANK())

RETURN likePerFollower 
```
# Analysis
## Findings

- What did we find?

For this analysis, we're going to focus on the questions below to get the information we need for our marketing client -

Here are the key questions we need to answer for our marketing client:

1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

### 1. Who are the top 10 YouTubers with the most subscribers?

|Rank|	Channel Name	|Subscribers (M)|
|----|--------|------|
|1	|NoCopyrightSounds|	33.60|
|2	|DanTDM	|28.60|
|3|	Dan Rhodes|	26.50|
|4|	Miss Katy	|24.50|
|5|	Mister| Max	|24.40|
|6|	KSI	|24.10|
|7|	Jelly|	23.50|
|8|	Dua Lipa	|23.30|
|9|	Sidemen	|21.00|
|10	|Ali-A	|18.90|

### 2. Which 3 channels have uploaded the most videos?
|Rank|	Channel Name|	Videos Uploaded|
|-------|--|--|
|1	|GRM Daily	|14,696|
|2	|Manchester City	|8,248|
|3	|Yogscast|	6,435|

### 4. Which 3 channels have the most views?
|Rank	|Channel Name	|Total Views (B)|
|-|-|-|
|1|	DanTDM	|19.78|
|2	|Dan Rhodes	|18.56|
|3	|Mister Max	|15.97|

### 5. Which 3 channels have the highest average views per video?
|Channel Name	|Averge Views per Video (M)|
|-|-|
|Mark Ronson	|32.27|
|Jessie J	|5.97|
|Dua Lipa|	5.76|

### 7. Which 3 channels have the highest views per subscriber ratio?
|Rank	|Channel Name|	Views per Subscriber|
|-|-|-|
|1	|GRM Daily	|1185.79|
|2|	Nickelodeon	|1061.04|
|3|	Disney Junior UK|	1031.97|

### 9. Which 3 channels have the highest subscriber engagement rate per video uploaded?
|Rank|	Channel Name|	Subscriber Engagement Rate|
|1|	Mark Ronson|	343,000|
|-|-|-|
|2|	Jessie J|	110,416.67|
|3	|Dua Lipa|	104,954.95|

### Notes

For this analysis, we'll prioritize analysing the metrics that are important in generating the expected ROI for our marketing client, which are the YouTube channels wuth the most

- subscribers
- total views
- videos uploaded

## Validation

### 1. Tiktokers influencers with the most Followers Analysis

#### Calculation breakdown

Campaign idea = product placement

1. Jason Derulo

- Average likes per Uploads = 1.29 million
- Product cost = £5
- Potential units sold per upload = 1.29 million x 2% conversion rate = 25,800 units sold
- Potential revenue per upload = 25,800 x £5 = £129,000 
- Campaign cost (one-time fee) = £50,000
- **Net profit = £129,000 - £50,000 = £79,000**

2. Carlos Feria

- Average likes per Uploads = 440,000
- Product cost = £5
- Potential units sold per upload = 440,000 x 2% conversion rate = 25,800 units sold
- Potential revenue per upload = 8,800 x £5 = £44,000 
- Campaign cost (one-time fee) = £50,000
- **Net profit = £44,000  - £50,000 = -£6,000**


3. Khabane lame

- Average likes per Uploads = 2 million
- Product cost = £5
- Potential units sold per upload = 2 million x 2% conversion rate =  40,000 units sold
- Potential revenue per upload = 40,000 x £5 = £200,000
- Campaign cost (one-time fee) = £50,000
- **Net profit = £200,000  - £50,000 = £150,000**
  
Best option from category: Khabane lame

##### SQL Query

```sql
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
	

  ```
##### Output

![total_followers_analysis](https://github.com/user-attachments/assets/de5e323f-8005-410a-83d4-481959c7cd8e)

### 2. Tiktokers influencers with the most likes

Campaign idea =  Influencer marketing

1. Charli d'amelio

- Average likes per Uploads = 4.2 million
- Product cost = £5
- Potential units sold per upload = 4.2 million x 2% conversion rate = 84,000 units sold
- Potential revenue per upload = 84,000 x £5 = £420,000 
- Campaign cost (one-time fee) = £50,000
- **Net profit = £420,000 - £50,000 = £370,000**

2. Ondy Mikula

- Average likes per Uploads = 1.18 million
- Product cost = £5
- Potential units sold per upload = 1.18 million x 2% conversion rate = 23,600 units sold
- Potential revenue per upload = 23,600 x £5 = £118,000 
- Campaign cost (one-time fee) = £50,000
- **Net profit = £118,000   - £50,000 = £68,000**


3. ESPN

- Average likes per Uploads = 200,000
- Product cost = £5
- Potential units sold per upload = 200,000 x 2% conversion rate =  4,000 units sold
- Potential revenue per upload = 4,000 x £5 = £20,000
- Campaign cost (one-time fee) = £50,000
- **Net profit = £20,000  - £50,000 = -£30,000**
  
Best option from category: Charli d'amelio

#### SQL Query

```sql
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
```
##### Output

![total_likes analysis](https://github.com/user-attachments/assets/2ac07281-7e74-4457-a8eb-489115a347de)


### 3. Tiktokers influencers with the most uploads Analysis

Campaign idea = sponsored video series

1. ESPN

- Average likes per Uploads = 200,000
- Product cost = £5
- Potential units sold per upload = 200,000 million x 2% conversion rate = 4,000 units sold
- Potential revenue per upload = 4,000 x £5 = £20,000 
- Campaign cost (one-time fee) = £50,000
- **Net profit = £20,000 - £50,000 = -£30,000**

2. Ondy Mikula

- Average likes per Uploads = 50,000
- Product cost = £5
- Potential units sold per upload = 50,000 x 2% conversion rate = 1,000 units sold
- Potential revenue per upload = 1,000 x £5 = £5,000 
- Campaign cost (one-time fee) = £50,000
- **Net profit = £5,000  - £50,000 = -£45,000**


3. Netflix

- Average likes per Uploads = 170,000
- Product cost = £5
- Potential units sold per upload = 170,000 x 2% conversion rate =  3,400 units sold
- Potential revenue per upload = 3,040 x £5 = £17,000
- Campaign cost (one-time fee) = £50,000
- **Net profit = £17,000  - £50,000 = -£33,000**
  
Best option from category: None

##### SQL Query

```sql
/*
  
  1. Define Variable
  2. Create a CTE that rounds the total uploads
  3. Select the columns that are required for the analysis
  4. fliter the result by the tiktokers influencer with the highest followers bases
  5. Order by net_profit (from highest to lowest)
  
  */

  -- 1. Define Variable
  Declare @conversionRate FLOAT = 0.02;		-- Conversion Rate @ 2%
  Declare @ProductCost MONEY = 5.0;			-- Product Rate @ $5
  Declare @CampaignCost MONEY = 50000.0;		-- Campaign Cost @ 50,000


  --   2. Create a CTE that rounds the total uploads

  WITH CTE_Tiktokers AS (
  SELECT 
    Username,
    total_followers,
    total_uploads,
    ROUND((CAST(total_likes AS FLOAT) / total_uploads), -4) AS rounded_avg_likes_for_all_uploads
  FROM 
    view_tiktokers_2025
)
SELECT 
  Username,
  rounded_avg_likes_for_all_uploads,
  (rounded_avg_likes_for_all_uploads * @conversionRate) AS potential_unit_sold_per_upload,
  (rounded_avg_likes_for_all_uploads * @conversionRate * @ProductCost) AS potential_revenue_per_upload,
  (rounded_avg_likes_for_all_uploads * @conversionRate * @ProductCost) - @CampaignCost AS net_profit
FROM 
  CTE_Tiktokers

-- 4. fliter the result by the tiktokers influencer with the highest followers bases
	WHERE Username IN ('ESPN', 'Ondy Mikula', 'Netflix')

-- 5. Order by net_profit (from highest to lowest)
	ORDER BY 
		net_profit DESC
```

##### Output
![total_uploads_analysis](https://github.com/user-attachments/assets/49f737b8-1a3f-423a-b6e8-b4d319ff6764)


# Discovery

- What did we learn?

We discovered that

1. Jason Derulo, Carlos Feria and Khabane lame are the Influencers with the most followers
2. Charli d'amelio, Barstool Sports and ESPN are the Influencers with the most likes on Tikok
3. ESPN, Ondy Mikula and Netflix are the influencers with the most uploads
4. Entertainment influencers are useful for broader reach, as the account posting consistently on their platforms and generating the most engagement are focus on entertainment and music
