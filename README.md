# Portfolio: Excel to Power BI
![Excel-powerbi](https://github.com/user-attachments/assets/ea9600a6-17fd-49c2-9c76-798d6c891daa)
# Table of contents

- [Objective](Objective)
- [Data Source](Data-Source)
- [Stages](Stages)
- [Design](Design)
  - [Mockup](Mockup)
  - [Tools](Tools)
- [Development](Development)
  - [Pseudocode](Pseudocode)
  - [Data Exploration](Data-Exploration)
  - [Data Cleaning](Data-Cleaning)
  - [Transform the Data](TransformtheData)
  - [Create the SQL View](CreatetheSQLView)
- [Testing](Testing)
  - [Data Quality Tests](Data-Quality-Tests)
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

The dashboard should display the top TikTok influencers, ranked based on:

- **Followers Count** – Total number of followers
- **Total Uploads** – The overall number of uploads
- **Average Likes per Upload** – The average number of likes received per upload 
- **Engagement Rate** – Measured by the ratio of likes to followers

This approach will enable the marketing team to make informed decisions when selecting TikTok influencers for brand campaigns.

## User story

As a Head of Marketing, I need a comprehensive ranking of top TikTok influencers based on key performance metrics to strategically select partners for brand campaigns.


# Data source

- What data is needed to achieve our objective?

To achieve our objectives, we need a dataset containing:

- Influencer Name
- Total Followers
- Total Following
- Total Uploads
- Total Likes

The data is sourced from an [Excel extract](https://www.kaggle.com/datasets/taimoor888/top-100-world-ranking-tiktok-accounts-in-2025), with influencer performance metrics collected for analysis.


# Stages

- Design
- Developement
- Testing
- Analysis

# Design

## Dashboard components required

- The dashboard should answer the following key questions:

1. Who are the top 10 TikTok influencers with the most followers?
2. Which 3 influencers have uploaded the most videos?
3. Which 3 influencers have the highest average likes per upload?
4. Which 3 influencers have the best engagement rate based on likes per follower?

For now, these are some of the questions we need to answer, this may change as we progress down our analysis.

## Dashboard mockup

- The visualizations will include:

1. Tables for ranking influencers
2. Treemaps for high-level comparisons
3. Scorecards for quick KPI insights
4. Bar Charts to compare performance metrics
 

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

1. Load the data into Excel for an initial scan.
2. Import the dataset into SQL Server for data cleaning.
3. Perform necessary transformations (removing nulls, renaming columns, formatting data types).
4. Create a SQL view to structure clean data for Power BI.
5. Load the cleaned dataset into Power BI for visualization.
6. Apply DAX measures to compute engagement rates and other metrics.
7. Publish insights and document findings on GitHub.


## Data exploration notes

This is the stage where you have a scan of what's in the data, errors, inconcsistencies, bugs, weird and corrupted characters etc

- What are your initial observations with this dataset? What's caught your attention so far?

1. There are at least 6 columns that contain the data we need for this analysis, which signals we have everything we need from the file without needing to contact the client for any more data.
2. The first column contains the Rank ID with what appears to be index number, its not necessary, so we removed it from the datasets.
4. We have the exact data we need for the analysis, so all the columns are retained except the Rank ID.

   
## Data cleaning

The cleaned dataset should meet these conditions:

- Only relevant columns are retained.
- No missing values in key performance fields.
- Appropriate data types assigned to each column.

Clean Data Schema

|Property	|Description|
|--------|----------|
|Number of Rows|	100|
|Number of Columns	|5|

And here is a tabular representation of the expected schema for the clean data:

|Column Name	|Data Type	|Nullable|
|------------|-----------|---------|
|Username |	NVARCHAR|NO|
|total_followers|INT|NO|
|total_following|SMALLINT|NO|
|total_uploads|	SMALLINT|NO|
|Total Likes |	BIGINT	|NO|

- What steps are needed to clean and shape the data into the desired format?

1. Remove unnecessary columns by only selecting the ones you need
2. Extract characters with ?? in each rows that represent emoji from the Tiktok Username
3. Captalize the first characters of each rows into proper from the Username

### Transform the data

```sql
/*
# Cleaning step
1. Remove the unneccessary columns by selecting the one we need					
2. Extract the unneccssary characters from the username column (?)				
3. Rename all column username to Upper e.g MrBeast, dixie to Dixie only!!!	
*/

-- 1.Remove the unneccessary columns by selecting the one we need
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

## Row Count Validation


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

## Column Count Validation


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

1. Top 10 Influencers ranked by follower count.
2. Highest engagement rates to assess influencer impact.
3. Average likes per uploads

![Untitled video - Made with Clipchamp](https://github.com/user-attachments/assets/9bf345be-8ace-4eb6-a43b-91ce19b1fee8)



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
### Average Likes per Upload (M)
```sql
Average Likes per Upload (M) = 
VAR sumOfTotalLikes = SUM(view_tiktokers_2025[total_likes])
VAR sumOfTotalUploads = SUM(view_tiktokers_2025[total_uploads])
VAR  avgLikesPerUpload = DIVIDE(sumOfTotalLikes,sumOfTotalUploads, BLANK())
VAR finalAvgLikesPerUpload = DIVIDE(avgLikesPerUpload, 1000000, BLANK())

RETURN finalAvgLikesPerUpload
```
### Followers Engagement Rate
```sql
Followers Engagement Rate = 
VAR sumOfTotalFollowers = SUM(view_tiktokers_2025[total_followers])
VAR sumOfTotalUploads = SUM(view_tiktokers_2025[total_uploads])
VAR followersEngRate = DIVIDE(sumOfTotalFollowers, sumOfTotalUploads, BLANK())

RETURN followersEngRate
```
### Likes Per Follower
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

1. Who are the top 10 Influencer with the most followers?
2. Which 3 Influencers have uploaded the most videos?
3. Which 3 Influencers have the most likes?
4. Which 3 channels have the highest average likes per video?
5. Which 3 channels have the highest subscriber engagement rate per video uploaded?

### 1. Who are the top 10 Influencer with the most followers?

|Rank|	Influencer	|Subscribers (M)|
|----|--------|------|
|1	| Jason Derulo |	652.20|
|2	|Carlos Feria	|468.00|
|3|	Khabane lame|	162.40|
|4|	Charli d'amelio	|155.70|
|5|	MrBeast	|107.50|
|6|	Bella Poarch	|94.30|
|7|	Addison Rae|	88.50|
|8|	Tiktok	|83.80|
|9|	Kimberly Loaiza	|83.10|
|10	|Zach King |82.10|

### 2. Which 3 Influencer have uploaded the most uploads?
|Rank|	Influencer |	Videos Uploaded|
|-------|--|--|
|1	|ESPN	|31,600|
|2	|Ondy Mikula	|13,200|
|3	|Netflix|	6,978|

### 3. Which 3 Influencer have the most likes?
|Rank	|Influencer	|Total likes (B)|
|-|-|-|
|1|	Charli d'amelio	|11.80|
|2	|Barstool Sports |8.20|
|3	|ESPN	|6.40|

### 4. Which 3 channels have the highest average likes per video?
|Channel Name	|Averge Views per Video (M)|
|-|-|
|Addison Rae|16.35|
|Kyle thomas |11.81|
|IShowSpeed|	10.43|


### 5. Which 3 channels have the highest subscriber engagement rate per video uploaded?
|Rank|	Channel Name|	Subscriber Engagement Rate|
|-|-|-|
|1|	IShowSpeed |	1,396,153.85|
|2|	BILLIE EILISH |	991,428.57|
|3	|Jason Derulo|	647,666.34|

### Notes

For this analysis, we'll prioritize analysing the metrics that are important in generating the expected ROI for our marketing client, which are the Tiktok influencers with the most

- followers
- total Likes
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


# Discovery:
**Key Insights from Data Analysis:**

**1. Top TikTok Influencers by Followers:**

- **Jason Derulo** leads with 652.2 million followers.
- **Carlos Feria** follows closely with 468 million followers.
- **Khabane Lame** holds the third spot with 162.4 million followers.

**2. Top TikTok Influencers by Likes:**

- **Charli D'Amelio** stands out with 11.8 billion likes.
- **Barstool Sports** ranks second with 8.2 billion likes.
- **ESPN** follows in third with 6.4 billion likes.

**3. Top TikTok Influencers by Uploads:**

- **ESPN** leads with 31,600 uploads.
- **Ondy Mikula** has uploaded 13,200 videos.
- **Netflix** ranks third with 6,978 uploads.

**4. Top TikTok Influencers by Engagement:**

- **IShowSpeed** has the highest engagement rate with 1.39 million engagement per upload.
- **Billie Eilish** follows with 991,428 engagements.
- **Jason Derulo** ranks third with 647,666 engagements.

We discovered that

- Influencers like **Jason Derulo**, **Carlos Feria**, and **Khabane Lame** have a vast audience base and high potential for reaching a broad demographic.
- **Charli D'Amelio**, **Barstool Sports**, and **ESPN** provide massive engagement opportunities due to their high number of likes and videos.
- **ESPN** and **Ondy Mikula** are the top players in terms of frequent uploads.

# Recommendation

### For a High-Impact Marketing Campaign:

- **Focus on Broad Reach:** Partner with influencers like **Jason Derulo**, **Carlos Feria**, and **Khabane Lame**. These influencers have an extensive follower base, ensuring maximum visibility for your brand.
- **Leverage Engagement**: Collaborate with Charli D'Amelio and Barstool Sports for a high level of audience interaction, making your campaign go viral.
- **Maximize Video Engagement**: Focus on influencers like **IShowSpeed** who have high engagement rates, ensuring that your message resonates with their audience.
- **Content Frequency**: Work with high-upload influencers like ESPN and Ondy Mikula to maintain consistent visibility over time.

### Campaign Focus:

1. **Product Placement** with influencers who have the most followers (e.g., Jason Derulo, Carlos Feria).
2. **Influencer Marketing** with influencers generating high engagement (e.g., Charli D'Amelio, Barstool Sports).
3. **Sponsored Series** targeting frequent uploaders (e.g., ESPN, Netflix).

## Potential ROI:

**Influencers with Best ROI Based on Followers:**

- **Jason Derulo (Top Choice):**
  - Average Likes per Upload: 1.29 million.
  - Campaign Cost: £50,000.
  - **Potential Revenue Per Upload:** £129,000 (from 1.29 million likes, 2% conversion = 25,800 units sold).
  - **Net Profit:** £79,000.

- **Carlos Feria:**
  - Average Likes per Upload: 440,000.
  - **Net Profit:** -£6,000 (unable to cover campaign cost).
    
- **Khabane Lame:**
  - Average Likes per Upload: 2 million.
  - **Net Profit:** £150,000 (Highest potential return).

**Best ROI from Category:**
- **Khabane Lame** shows the highest net profit, making him the most lucrative influencer for product placement campaigns.

**Influencers with Best ROI Based on Likes:**
- **Charli D'Amelio (Top Choice):**
  - Average Likes per Upload: 4.2 million.
  - **Net Profit:** £370,000 (highest profit).

- **Ondy Mikula:**
  - Average Likes per Upload: 1.18 million.
  - Net Profit: £68,000.

- **ESPN:**
  - Average Likes per Upload: 200,000.
  - Net Profit: -£30,000 (negative ROI).
    
**Best ROI from Category:**
- **Charli D'Amelio** provides the highest ROI based on total likes, making her a prime candidate for influencer marketing campaigns.

**Influencers with Best ROI Based on Uploads:**
- **ESPN (Top Choice):** High upload frequency, though lower net profit due to lower engagement.
 - **Net Profit:** -£30,000.


**Best ROI from Category:**

- None of the top influencers with the highest uploads show significant profit based on the current data. However, more frequent uploads can be beneficial for long-term campaigns if engagement can be increased.


# Action Plan:

**1. Select Top Influencers:**

- **Short-Term:** Choose **Jason Derulo** and **Charli D'Amelio** for large-scale campaigns that require high visibility and engagement.
- **Long-Term:** Collaborate with **Khabane Lame** for sustained high-impact campaigns.
- **Engagement-Focused:** Partner with influencers like **IShowSpeed** for highly engaged content.



