SHOW VARIABLES LIKE "secure_file_priv";
SET GLOBAL local_infile = 1;

CREATE TABLE divvy_tripdata_202509 (
ride_id text,
rideable_type text,
started_at text,
ended_at text,
start_station_name text,
start_station_id text,
end_station_name text,
end_station_id text,
start_lat double,
start_lng double,
end_lat double,
end_lng double,
member_casual text
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/202509-divvy-tripdata.csv'
INTO TABLE divvy_tripdata_202509
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- test
SELECT 
	*
FROM 
	bike_share.divvy_tripdata_202509;

SELECT
	COUNT(*)
FROM
	bike_share.divvy_tripdata_202509;
