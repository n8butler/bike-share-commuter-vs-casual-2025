-- 1. Create staging copies (create tables, import data)
-- 2. Remove duplicates
-- 3. Fix issues with data (i.e. column type changes, spaces, incorrect charactors, etc.)
-- 4. Fix null or blank values (As it relates to analysis problem. NULL values by themselves aren't necessarily a big deal).
-- 5. If applicable, consider removing any columns and rows (do with caution).

SELECT *
FROM bike_share.divvy_tripdata_202409;

-- 1. Create staging copies (create tables, import data)
-- table staging duplication
CREATE TABLE bike_share.divvy_tripdata_202409_staging
LIKE bike_share.divvy_tripdata_202409;

CREATE TABLE bike_share.divvy_tripdata_202410_staging
LIKE bike_share.divvy_tripdata_202410;

CREATE TABLE bike_share.divvy_tripdata_202411_staging
LIKE bike_share.divvy_tripdata_202411;

CREATE TABLE bike_share.divvy_tripdata_202412_staging
LIKE bike_share.divvy_tripdata_202412;

CREATE TABLE bike_share.divvy_tripdata_202501_staging
LIKE bike_share.divvy_tripdata_202501;

CREATE TABLE bike_share.divvy_tripdata_202502_staging
LIKE bike_share.divvy_tripdata_202502;

CREATE TABLE bike_share.divvy_tripdata_202503_staging
LIKE bike_share.divvy_tripdata_202503;

CREATE TABLE bike_share.divvy_tripdata_202504_staging
LIKE bike_share.divvy_tripdata_202504;

CREATE TABLE bike_share.divvy_tripdata_202505_staging
LIKE bike_share.divvy_tripdata_202505;

CREATE TABLE bike_share.divvy_tripdata_202506_staging
LIKE bike_share.divvy_tripdata_202506;

CREATE TABLE bike_share.divvy_tripdata_202507_staging
LIKE bike_share.divvy_tripdata_202507;

CREATE TABLE bike_share.divvy_tripdata_202508_staging
LIKE bike_share.divvy_tripdata_202508;

CREATE TABLE bike_share.divvy_tripdata_202509_staging
LIKE bike_share.divvy_tripdata_202509;

-- table data duplication
INSERT bike_share.divvy_tripdata_202509_staging
SELECT *
FROM bike_share.divvy_tripdata_202509;

SELECT *
FROM bike_share.divvy_tripdata_202509_staging;

-- 2. Remove duplicates

SELECT *
FROM bike_share.divvy_tripdata_202409_staging;

SELECT
	t1.*
FROM
	bike_share.divvy_tripdata_202509_staging AS t1
JOIN
	bike_share.divvy_tripdata_202509_staging AS t2 ON t1.ride_id = t2.ride_id
    AND t1.rideable_type = t2.rideable_type
    AND t1.started_at = t2.started_at
    AND t1.ended_at = t2.ended_at
    AND t1.start_station_name = t2.start_station_name
    AND t1.start_station_id = t2.start_station_id
    AND t1.end_station_name = t2.end_station_name
    AND t1.end_station_id = t2.end_station_id
    AND t1.start_lat = t2.start_lat
    AND t1.start_lng = t2.start_lng
    AND t1.end_lat = t2.end_lat
    AND t1.end_lng = t2.end_lng
    AND t1.member_casual = t2.member_casual
    AND t1.ride_id <> t2.ride_id;
	
-- All staging tables were self-joined with no duplicates found

-- 3. Fix issues with data (i.e. column type changes, spaces, incorrect charactors, etc.)

SELECT *
FROM bike_share.divvy_tripdata_202409_staging;

SELECT
	ride_id,
    rideable_type,
    member_casual
FROM
	bike_share.divvy_tripdata_202409_staging;

-- looking at blanks, empty strings, and strings with one or more spaces
-- station names and id's are obviously blank on purpose, likely the bike was picked up and dropped off outside a station.

-- check for blanks in other important text columns
SELECT
	*
FROM
	bike_share.divvy_tripdata_202509_staging
WHERE
	NULLIF(TRIM(ride_id),'') IS NULL
    OR NULLIF(TRIM(rideable_type),'') IS NULL
	OR NULLIF(TRIM(started_at),'') IS NULL
    OR NULLIF(TRIM(ended_at),'') IS NULL
    OR NULLIF(TRIM(member_casual),'') IS NULL;
    
-- Ran through all files. No blanks or empty strings found.
-- Look at the unique range of values for important columns.
-- Seems like a grey area between cleaning and analysis

SELECT *
FROM bike_share.divvy_tripdata_202409_staging;

-- find unique rideable types and their occurances
SELECT DISTINCT 
	rideable_type,
    COUNT(rideable_type) AS rideable_type_count
FROM 
	bike_share.divvy_tripdata_202409_staging
GROUP BY
	rideable_type;

-- briefly explore the number of stations in the same way
SELECT DISTINCT
	start_station_id,
    COUNT(start_station_id) start_station_id_count
FROM
	bike_share.divvy_tripdata_202409_staging
GROUP BY
	start_station_id;
    
-- look at all rideable_type and member_casual combination counts by file
-- There is probably a slicker way to do this with a cte. If nothing else the results can act as a check on the progressive analysis by date that will come later.  
SELECT
	table_source,
    rideable_type,
    member_casual,
    COUNT(*) AS value_count
FROM (
	SELECT 
		rideable_type,
        member_casual,
		'202409' AS table_source 
	FROM bike_share.divvy_tripdata_202409_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202410' AS table_source 
	FROM bike_share.divvy_tripdata_202410_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202411' AS table_source 
	FROM bike_share.divvy_tripdata_202411_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202412' AS table_source 
	FROM bike_share.divvy_tripdata_202412_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202501' AS table_source 
	FROM bike_share.divvy_tripdata_202501_staging
	UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202502' AS table_source 
	FROM bike_share.divvy_tripdata_202502_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202503' AS table_source 
	FROM bike_share.divvy_tripdata_202503_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202504' AS table_source 
	FROM bike_share.divvy_tripdata_202504_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202505' AS table_source 
	FROM bike_share.divvy_tripdata_202505_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202506' AS table_source 
	FROM bike_share.divvy_tripdata_202506_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202507' AS table_source 
	FROM bike_share.divvy_tripdata_202507_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202508' AS table_source 
	FROM bike_share.divvy_tripdata_202508_staging
    UNION ALL
    SELECT 
		rideable_type,
        member_casual,
		'202509' AS table_source 
	FROM bike_share.divvy_tripdata_202509_staging
) AS combined_results
GROUP BY
	table_source,
    rideable_type,
    member_casual
ORDER BY
	table_source,
    rideable_type,
    member_casual;

-- explore the max and min of all the double columns (i.e. latitude, longitude columns)
SELECT
    MAX(start_lat) AS start_lat_max,
    MIN(start_lat) AS start_lat_min,
    MAX(start_lng) AS start_lng_max,
    MIN(start_lng) AS start_lng_min,
    MAX(end_lat) AS end_lat_max,
    MIN(end_lat) AS end_lat_min,
    MAX(end_lng) AS end_lng_max,
    MIN(end_lng) AS end_lng_min
FROM 
	bike_share.divvy_tripdata_202509_staging;
-- performed this for each file and compiled in CapstoneOne_Documentation.xls
-- some ranges far outside of what is expected for Chicago. Data is suspect.

SELECT *
FROM bike_share.divvy_tripdata_202411_staging;



