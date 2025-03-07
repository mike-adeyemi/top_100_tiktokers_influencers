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

