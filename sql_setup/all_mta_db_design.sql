-- Push local file to remote server: TERMINAL:
-- # example upload to remote server
-- scp [source file] [username]@[destination server]:.
-- # load from remote server
-- scp cool_stuff.txt sanjeev@example.com:.


-- Remote TERMINAL :
-- mysql --local-infile=1 -u root -p
-- mysql
-- 


-- mysql comands:
-- 
SHOW DATABASES;
CREATE mta;
USE mta;


--------------------------------
-- UNION / INSERT - ALL AUDITS
--------------------------------
CREATE 
 TABLE long_sun_cnts_by_turnstile_all

SELECT ca
	 , unit
	 , scp
	 , audit_date
	 , start_time
	 , end_time
	 , entry_start_cnt
	 , entry_end_cnt
	 , entry_period_cnt
	 , exit_start_cnt
	 , exit_end_cnt
	 , exit_period_cnt

  
  FROM long_sun_cnts_by_turnstile

UNION ALL

SELECT *
  
  FROM long_sun_cnts_by_turnstile_old;



--------------------------------
CREATE 
 TABLE long_sat_cnts_by_turnstile_all

SELECT ca
	 , unit
	 , scp
	 , audit_date
	 , start_time
	 , end_time
	 , entry_start_cnt
	 , entry_end_cnt
	 , entry_period_cnt
	 , exit_start_cnt
	 , exit_end_cnt
	 , exit_period_cnt

  
  FROM long_sat_cnts_by_turnstile

UNION ALL

SELECT *
  
  FROM long_sat_cnts_by_turnstile_old;

--------------------------------
CREATE 
 TABLE fri_nite_cnts_by_turnstile_all

SELECT ca
	 , unit
	 , scp
	 , audit_date
	 , audit_week
	 , start_time
	 , end_time
	 , entry_start_cnt
	 , entry_end_cnt
	 , entry_period_cnt
	 , exit_start_cnt
	 , exit_end_cnt
	 , exit_period_cnt

  
  FROM fri_nite_cnts_by_turnstile

UNION ALL

SELECT *
  
  FROM fri_nite_cnts_by_turnstile_old;
-----------------------------------------
CREATE 
 TABLE sat_nite_cnts_by_turnstile_all

SELECT ca
	 , unit
	 , scp
	 , audit_date
	 , audit_week
	 , start_time
	 , end_time
	 , entry_start_cnt
	 , entry_end_cnt
	 , entry_period_cnt
	 , exit_start_cnt
	 , exit_end_cnt
	 , exit_period_cnt

  
  FROM sat_nite_cnts_by_turnstile

UNION ALL

SELECT *
  
  FROM sat_nite_cnts_by_turnstile_old;
-----------------------------------------
-----------------------------------------

-- 						   CUMULATIVE
-- BRUNCH - SUNDAY       ENTRIES / EXITS
-- BRUNCH - SATURDAY 
--   11am - 5pm			   BY STATION 

-----------------------------------------

-----------------------------------------
--  SUNDAY BRUNCH
-----------------------------------------

-- CREATE TABLE FOR ALL STATIONS ( id = unit )
CREATE 
 TABLE long_sun_cnts_by_station_all

SELECT unit
     , audit_date
     , station_entry_total_cnt
     , station_exit_total_cnt

  FROM long_sun_cnts_by_station

UNION ALL

SELECT *
  
  FROM long_sun_cnts_by_station_old;

-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------

CREATE 
 TABLE long_sat_cnts_by_station_all

SELECT unit
     , audit_date
     , station_entry_total_cnt
     , station_exit_total_cnt

  FROM long_sat_cnts_by_station

UNION ALL

SELECT *
  
  FROM long_sat_cnts_by_station_old;

-----------------------------------------
--  FRIDAY NITE
-----------------------------------------

CREATE 
 TABLE fri_nite_cnts_by_station_all

SELECT unit
     , audit_date
     , station_entry_total_cnt
     , station_exit_total_cnt

  FROM fri_nite_cnts_by_station

UNION ALL

SELECT *
  
  FROM fri_nite_cnts_by_station_old;

-----------------------------------------
--  SATURDAY NITE
-----------------------------------------

CREATE 
 TABLE sat_nite_cnts_by_station_all

SELECT unit
     , audit_date
     , station_entry_total_cnt
     , station_exit_total_cnt

  FROM sat_nite_cnts_by_station

UNION ALL

SELECT *
  
  FROM sat_nite_cnts_by_station_old;
-----------------------------------------
--  NOTE : Data entry ERROR !!!!!!!!
-----------------------------------------

-- OUTLIER!!!!!!!


-- -- user error :SELECT * FROM long_sun_brunch WHERE unit = 'R029' AND audit_week = 5;
-- +------+------+----------+-----------------+----------+----------+------------+------------+-----------+------------+-------------+-----------+-----------+
-- | ca   | unit | scp      | station         | linename | division | audit_date | audit_time | audit_day | audit_week | description | entries   | exits     |
-- +------+------+----------+-----------------+----------+----------+------------+------------+-----------+------------+-------------+-----------+-----------+
-- | N092 | R029 | 03-06-00 | CHAMBERS ST     | ACE23    | IND      | 2015-02-01 | 11:00:00   |         1 |          5 | REGULAR     |   1408391 |   1419017 | <<<<< !!!!!
-- | N092 | R029 | 03-06-00 | CHAMBERS ST     | ACE23    | IND      | 2015-02-01 | 15:00:00   |         1 |          5 | REGULAR     | 352356225 | 352327596 | <<<<< !!!!!
-- +------+------+----------+-----------------+----------+----------+------------+------------+-----------+------------+-------------+-----------+-----------+



-----------------------------------------
-- 						   CUMULATIVE
-- BRUNCH - SUNDAY       ENTRIES / EXITS
-- BRUNCH - SATURDAY 
--   11am - 5pm				BY DATE

-----------------------------------------
-----------------------------------------
--  SUNDAY BRUNCH
-----------------------------------------
CREATE 
 TABLE long_sun_total_cnts_all

SELECT *

  FROM long_sun_total_cnts

UNION ALL

SELECT *
  
  FROM long_sun_total_cnts_old;
-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------
CREATE 
 TABLE long_sat_total_cnts_all

SELECT *

  FROM long_sat_total_cnts

UNION ALL

SELECT *
  
  FROM long_sat_total_cnts_old;

-----------------------------------------
--  FRIDAY NITE
-----------------------------------------
CREATE 
 TABLE fri_nite_total_cnts_all

SELECT *

  FROM fri_nite_total_cnts

UNION ALL

SELECT *
  
  FROM fri_nite_total_cnts_old;

-----------------------------------------
--  SATURDAY NITE
-----------------------------------------
CREATE 
 TABLE sat_nite_total_cnts_all

SELECT *

  FROM sat_nite_total_cnts

UNION ALL

SELECT *
  
  FROM sat_nite_total_cnts_old;
-----------------------------------------

-- 						  PROPORTION OF 
-- BRUNCH - SUNDAY       ENTRIES / EXITS
-- BRUNCH - SATURDAY 
--   11am - 5pm				BY DATE

-----------------------------------------
-----------------------------------------
--  SUNDAY BRUNCH --  ALL DATES: 
-----------------------------------------
CREATE 
 TABLE sun_date_list_all

SELECT *
  FROM sun_date_list

UNION ALL

SELECT *
  FROM sun_date_list_old;

-----------------------------------------
--  SATURDAY  --  ALL DATES: 
-----------------------------------------
CREATE 
 TABLE sat_date_list_all

SELECT *
  FROM sat_date_list

UNION ALL

SELECT *
  FROM sat_date_list_old;

-----------------------------------------
--  FRIDAY NITE --  ALL DATES: 
-----------------------------------------
CREATE 
 TABLE fri_date_list_all

SELECT *
  FROM fri_date_list

UNION ALL

SELECT *
  FROM fri_date_list_old;


-----------------------------------------

-- 			STATION   GEOCODES

-----------------------------------------
CREATE TABLE mta_geocodes(
	unit VARCHAR(255),
	ca VARCHAR(255),
	station VARCHAR(255),
	linename VARCHAR(255),
	division VARCHAR(255),
	latitude DOUBLE,
	longitude DOUBLE
);

--  LOAD file DATA into TABLE: MySQL
LOAD DATA LOCAL INFILE "geocoded.csv"
    INTO TABLE mta_new FIELDS TERMINATED BY ",";


