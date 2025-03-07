/*

# Cleaning step

1. Remove the unneccessary columns by selecting the one we need					passed...
2. Extract the unneccssary characters from the username column (?)				passed...
3. Rename all column username to Upper e.g MrBeast, dixie to Dixie only!!!		passed...



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


--		2. Extract the unneccssary characters from the username column (?)
	
--		 Preview query before Updating the column

		SELECT Username,
		LTRIM(RTRIM(REPLACE(REPLACE(Username,'?', ''), ' ', ' ')))
		AS Cleaned_Username 
		FROM top_100_tiktokers_2025
		WHERE Username LIKE '%?%';


--		Update the column Username to remove all spacing left, right and removed it from where ? is replaced with space

		UPDATE top_100_tiktokers_2025
		SET Username = 
		LTRIM(RTRIM(REPLACE(REPLACE(Username, '?', ''), ' ', ' ')));


--		3. Rename all column username to Upper e.g mrBeast to MrBeast, dixie to Dixie only
--		 Preview query for changing the Username column first character into Proper Case

SELECT Username,
		UPPER(LEFT(Username, 1)) +
		RIGHT(Username, LEN(Username) - 1) as
		Cleaned_Username
		FROM top_100_tiktokers_2025;

--		Now update the column to change the first letter into proper case
		
		
		UPDATE top_100_tiktokers_2025
		SET Username = UPPER(LEFT(Username, 1)) + 
		RIGHT(Username, LEN(Username) - 1);


--		How to create view that will load into power bi

		CREATE VIEW view_tiktokers_2025 AS
		SELECT 
		Username,
		total_followers,
		total_following,
		total_uploads,
		total_likes
		FROM 
		top_100_tiktokers_2025;