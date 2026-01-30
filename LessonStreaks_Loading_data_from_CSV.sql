-- Create the table first with columns and data types that match your CSV file structure. 
Drop table lessonstreaks;

CREATE TABLE `lessonstreaks` (
  `id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  `date` text,
  `user_id` int DEFAULT NULL,
  `user_name` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



select * from lessonstreaks;

-- Enable the local_infile option on both the MySQL server and the client side. 
SET GLOBAL local_infile = 1; 

/* bash 
Enable on the client: When you connect to MySQL using the command-line client, use the --local-infile option:

c:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p data_drill --local-infile=1
Enter password: ****************
*/


/*

MySql Workbench setting.

🧭 Option 1: Enable it through Workbench Preferences

(works on most recent versions)

Open MySQL Workbench

Go to the top menu bar →
Edit → Preferences

In the left panel, choose SQL Editor

Scroll all the way down to find:

"Allow LOAD DATA LOCAL INFILE"


✅ Check this box.

Click Apply → OK

Reconnect to your database (close and open the connection again).

🧰 Option 2: Enable via Connection Settings (if the above option is missing)

In Workbench, go to the Home screen

Right-click your connection → Edit Connection

Click Advanced tab

Scroll to Others field (bottom of the dialog)

Add this text (if not already present):

OPT_LOCAL_INFILE=1


Click OK, then reconnect.

*/


/*
LOAD DATA LOCAL INFILE "C:\\Users\\rimac\\OneDrive\\Desktop\\Maven Data Drill\\6. Streak Leaderboard\\LessonStreaks.csv"
INTO TABLE lesson_streaks
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Use this if your CSV file has a header row
*/

/*
Warnings: 1785144
…it means MySQL did load the data, but there were data conversion issues in many rows (not a load failure).
*/




LOAD DATA LOCAL INFILE "C:\\Users\\rimac\\OneDrive\\Desktop\\Maven Data Drill\\6. Streak Leaderboard\\LessonStreaks.csv"
INTO TABLE lessonstreaks
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- SET user_id = NULLIF(TRIM(@user_id), '');

SHOW WARNINGS LIMIT 10;


/* This took only 7.109 seconds to load ~900K records from CSV file. */

select * from lessonstreaks;
