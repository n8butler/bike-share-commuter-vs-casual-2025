-- the following queries exclude electric scooters, august 2024, and september 2025 data so that the resulting tables represent a 4 full seasonal 12 month period

-- by ride type
SELECT
	rideable_type,
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual_count,
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member_count,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'casual' THEN TIME_TO_SEC(ride_length) END))) AS casual_avg_duration,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'member' THEN TIME_TO_SEC(ride_length) END))) AS member_avg_duration
FROM
	bike_share.divvy_tripdata_202409_thru_202509_staging
WHERE 
	TIME_TO_SEC(ride_length) > 0 -- 43 occurances of negative time durations were discovered for 11/03/24 between 1-2AM. Likely a system maintenance/update.
    AND rideable_type != 'electric_scooter'
    AND source_table != '202408'
    AND source_table != '202509'
GROUP BY
	rideable_type
ORDER BY
	rideable_type;

-- by hour of the day
SELECT
    HOUR(STR_TO_DATE(started_at, '%Y-%m-%d %H:%i:%s.%f')) AS hour_of_day,
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual_count,
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member_count,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'casual' THEN TIME_TO_SEC(ride_length) END))) AS casual_avg_duration,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'member' THEN TIME_TO_SEC(ride_length) END))) AS member_avg_duration
FROM 
	bike_share.divvy_tripdata_202409_thru_202509_staging
WHERE 
	TIME_TO_SEC(ride_length) > 0
    AND rideable_type != 'electric_scooter'
    AND source_table != '202408'
    AND source_table != '202509' 
GROUP BY 
	hour_of_day
ORDER BY 
	hour_of_day;

-- by ride length buckets
SELECT
    member_casual,
    CASE 
        WHEN TIME_TO_SEC(ride_length) < 300 THEN '0-5 min'
        WHEN TIME_TO_SEC(ride_length) < 600 THEN '5-10 min'
        WHEN TIME_TO_SEC(ride_length) < 900 THEN '10-15 min'
        WHEN TIME_TO_SEC(ride_length) < 1800 THEN '15-30 min'
        WHEN TIME_TO_SEC(ride_length) < 3600 THEN '30-60 min'
        ELSE '60+ min'
    END AS duration_bucket,
    COUNT(*) AS trip_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual), 2) AS pct_of_type
FROM bike_share.divvy_tripdata_202409_thru_202509_staging
WHERE TIME_TO_SEC(ride_length) > 0
AND rideable_type != 'electric_scooter'
AND source_table != '202408'
AND source_table != '202509'
GROUP BY member_casual, duration_bucket
ORDER BY member_casual, MIN(TIME_TO_SEC(ride_length));

-- by day of the week
SELECT
	day_of_week,
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual_count,
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member_count,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'casual' THEN TIME_TO_SEC(ride_length) END))) AS casual_avg_duration,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'member' THEN TIME_TO_SEC(ride_length) END))) AS member_avg_duration
FROM
	bike_share.divvy_tripdata_202409_thru_202509_staging
WHERE 
	TIME_TO_SEC(ride_length) > 0
    AND rideable_type != 'electric_scooter'
    AND source_table != '202408'
    AND source_table != '202509' 
GROUP BY
	day_of_week
ORDER BY
	FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- by month
SELECT
    DATE_FORMAT(STR_TO_DATE(started_at, '%Y-%m-%d %H:%i:%s.%f'), '%Y-%m') AS month,
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual_count,
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member_count,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'casual' THEN TIME_TO_SEC(ride_length) END))) AS casual_avg_duration,
    SEC_TO_TIME(ROUND(AVG(CASE WHEN member_casual = 'member' THEN TIME_TO_SEC(ride_length) END))) AS member_avg_duration
FROM 
	bike_share.divvy_tripdata_202409_thru_202509_staging
WHERE 
	TIME_TO_SEC(ride_length) > 0
    AND rideable_type != 'electric_scooter'
    AND source_table != '202408'
    AND source_table != '202509'
GROUP BY 
	month
ORDER BY 
	month;

SELECT *
FROM bike_share.divvy_tripdata_202409_thru_202509_staging;