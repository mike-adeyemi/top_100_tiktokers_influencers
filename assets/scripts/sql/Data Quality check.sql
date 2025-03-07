/*

# Data Quality tests

1. The data needs to be 100 records of tiktokers (row count test)			(passed!!!)
2. The data needs 4 fields (column count test)								(passed!!!)
3. The username column must be in string format and others columns must be numerical data types (data types check)	(passed!!!)
4. Each records must be unique in the dataset (duplicate count check)			(passed!!!)


Row count - 100 
coumn count - 5 

Data types

Username = STRINGS
total_followers = INTERGER
total_following = INTERGER
total_uploads = INTERGER
total likes = INTEGER

Duplicate count = 0

*/

--	1. Row count check

	SELECT 
		COUNT(*) 
		as no_of_rows
	FROM 
	view_tiktokers_2025;


--	2. coumn count test

	SELECT 
		COUNT(*) as column_count
	FROM 
		INFORMATION_SCHEMA.COLUMNS
	WHERE 
		TABLE_NAME = 'view_tiktokers_2025';

-- 3. Data types check

SELECT 
		COLUMN_NAME,
		DATA_TYPE 
	FROM 
		INFORMATION_SCHEMA.COLUMNS
	WHERE 
		TABLE_NAME = 'view_tiktokers_2025';

--		4. Duplicate records count 

	SELECT Username,
		COUNT(*) as duplicate_count
	FROM 
		view_tiktokers_2025
	GROUP BY Username
	HAVING COUNT(*) > 1;
