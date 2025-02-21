# Data Portfolio: Excel to Power BI


![kaggle_to_powerbi](https://github.com/user-attachments/assets/e009bd3e-f886-413a-ab99-8a4df0698ce0)

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

-  What is the key pain point?


The Head of Marketing wants to find out who the top YouTubers are in 2024 to decide on which YouTubers would be best to run marketing campaigns throughout the rest of the year.

-  What is the ideal solution?


To create a dashboard that provides insights into the top UK YouTubers in 2024 that includes their

- subscriber count
- total views
- total videos, and
- engagement metrics

This will help the marketing team make informed decisions about which YouTubers to collaborate with for their marketing campaigns.

## User story

As the Head of Marketing, I want to use a dashboard that analyses YouTube channel data in the UK .


This dashboard should allow me to identify the top performing channels based on metrics like subscriber base and average views.


With this information, I can make more informed decisions about which Youtubers are right to collaborate with, and therefore maximize how effective each marketing campaign is.


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
- Potential units sold per video = 6.92 million x 2% conversion rate = 138,400 units sold
- Potential revenue per video = 138,400 x $5 = $692,000
- Campaign cost (one-time fee) = $50,000
- Net profit = $692,000 - $50,000 = $642,000
