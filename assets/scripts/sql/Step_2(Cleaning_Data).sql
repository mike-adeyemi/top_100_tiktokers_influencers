/*

# Cleaning step

1. Remove the unneccessary columns by selecting the one we need					passed...
2. Extract the unneccssary characters from the username column (?)				passed...
3. Rename all column username to Upper e.g MrBeast, dixie to Dixie only!!!		passed...



*/

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
