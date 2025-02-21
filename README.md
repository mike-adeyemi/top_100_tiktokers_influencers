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
