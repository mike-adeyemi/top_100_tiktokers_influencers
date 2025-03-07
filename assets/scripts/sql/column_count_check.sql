/*

# Data Quality tests

1. The data needs to be 100 records of tiktokers (row count test)			(passed!!!)
2. The data needs 4 fields (column count test)								(passed!!!)
3. The username column must be in string format and others columns must be numerical data types (data types check)	(passed!!!)
4. Each records must be unique in the dataset (duplicate count check)			(passed!!!)


coumn count - 5 

*/
--	2. coumn count test

	SELECT 
		COUNT(*) as column_count
	FROM 
		INFORMATION_SCHEMA.COLUMNS
	WHERE 
		TABLE_NAME = 'view_tiktokers_2025';