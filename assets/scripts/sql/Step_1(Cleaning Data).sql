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