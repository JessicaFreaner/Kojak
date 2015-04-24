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



-- Field Description

-- C/A,UNIT,SCP,
-- DATE1,TIME1,DESC1,ENTRIES1,EXITS1,
-- DATE2,TIME2,DESC2,ENTRIES2,EXITS2,
-- DATE3,TIME3,DESC3,ENTRIES3,EXITS3,
-- DATE4,TIME4,DESC4,ENTRIES4,EXITS4,
-- DATE5,TIME5,DESC5,ENTRIES5,EXITS5,
-- DATE6,TIME6,DESC6,ENTRIES6,EXITS6,
-- DATE7,TIME7,DESC7,ENTRIES7,EXITS7,
-- DATE8,TIME8,DESC8,ENTRIES8,EXITS8


-- C/A = Control Area (A002)
-- UNIT = Remote Unit for a station (R051)
-- SCP = Subunit Channel Position represents an specific address for a device (02-00-00)
-- DATEn = Represents the date (MM-DD-YY)
-- TIMEn = Represents the time (hh:mm:ss) for a scheduled audit event
-- DEScn = Represent the "REGULAR" scheduled audit event (occurs every 4 hours)
-- ENTRIESn = The comulative entry register value for a device
-- EXISTn = The cumulative exit register value for a device

CREATE 
 TABLE mta_old(
	ca VARCHAR(255)
	, unit VARCHAR(255)
	, scp VARCHAR(255)
	, audit_date1 VARCHAR(255)
	, audit_time1 TIME
	, description1 VARCHAR(255)
	, entries1 INT
	, exits1 INT
	, audit_date2 VARCHAR(255)
	, audit_time2 TIME
	, description2 VARCHAR(255)
	, entries2 INT
	, exits2 INT
	, audit_date3 VARCHAR(255)
	, audit_time3 TIME
	, description3 VARCHAR(255)
	, entries3 INT
	, exits3 INT
	, audit_date4 VARCHAR(255)
	, audit_time4 TIME
	, description4 VARCHAR(255)
	, entries4 INT
	, exits4 INT
	, audit_date5 VARCHAR(255)
	, audit_time5 TIME
	, description5 VARCHAR(255)
	, entries5 INT
	, exits5 INT
	, audit_date6 VARCHAR(255)
	, audit_time6 TIME
	, description6 VARCHAR(255)
	, entries6 INT
	, exits6 INT
	, audit_date7 VARCHAR(255)
	, audit_time7 TIME
	, description7 VARCHAR(255)
	, entries7 INT
	, exits7 INT
	, audit_date8 VARCHAR(255)
	, audit_time8 TIME
	, description8 VARCHAR(255)
	, entries8 INT
	, exits8 INT
);


-- LOAD file names into LIST; CONCAT list 
ls  *txt  > old_format_list.txt
cat old_format_list.txt | xargs cat > ALLOLD.txt

--  LOAD file DATA into TABLE: MySQL
LOAD DATA LOCAL INFILE "ALLOLD.txt"
    INTO TABLE mta_old FIELDS TERMINATED BY "," IGNORE 1 LINES;

-----------------------------------------
-- CREATE Table mta_old_to_new_form 
-----------------------------------------

--------------
-- AUDIT 1
--------------

CREATE 
 TABLE mta_old_to_new_form1

SELECT ca
     , unit
     , scp
     , audit_date1 as audit_date
     , audit_time1 as audit_time
     , description1 as description
     , entries1 as entries
     , exits1 as exits

  FROM mta_old;

--------------
-- AUDIT 2
--------------
 
CREATE 
 TABLE mta_old_to_new_form2

SELECT ca
     , unit
     , scp
     , audit_date2 as audit_date
     , audit_time2 as audit_time
     , description2 as description
     , entries2 as entries
     , exits2 as exits

  FROM mta_old;

--------------
-- AUDIT 3
--------------

CREATE 
 TABLE mta_old_to_new_form3

SELECT ca
     , unit
     , scp
     , audit_date3 as audit_date
     , audit_time3 as audit_time
     , description3 as description
     , entries3 as entries
     , exits3 as exits

  FROM mta_old;

--------------
-- AUDIT 4
--------------

CREATE 
 TABLE mta_old_to_new_form4

SELECT ca
     , unit
     , scp
     , audit_date4 as audit_date
     , audit_time4 as audit_time
     , description4 as description
     , entries4 as entries
     , exits4 as exits

  FROM mta_old;

--------------
-- AUDIT 5
--------------

CREATE 
 TABLE mta_old_to_new_form5

SELECT ca
     , unit
     , scp
     , audit_date5 as audit_date
     , audit_time5 as audit_time
     , description5 as description
     , entries5 as entries
     , exits5 as exits

  FROM mta_old;

--------------
-- AUDIT 6
--------------

CREATE 
 TABLE mta_old_to_new_form6

SELECT ca
     , unit
     , scp
     , audit_date6 as audit_date
     , audit_time6 as audit_time
     , description6 as description
     , entries6 as entries
     , exits6 as exits

  FROM mta_old;

--------------
-- AUDIT 7
--------------

CREATE 
 TABLE mta_old_to_new_form7

SELECT ca
     , unit
     , scp
     , audit_date7 as audit_date
     , audit_time7 as audit_time
     , description7 as description
     , entries7 as entries
     , exits7 as exits

  FROM mta_old;

--------------
-- AUDIT 8
--------------

CREATE 
 TABLE mta_old_to_new_form8

SELECT ca
     , unit
     , scp
     , audit_date8 as audit_date
     , audit_time8 as audit_time
     , description8 as description
     , entries8 as entries
     , exits8 as exits

  FROM mta_old;


--------------------------------
-- UNION / INSERT - ALL AUDITS
--------------------------------
CREATE 
 TABLE mta_old_to_new_form

SELECT *
  
  FROM mta_old_to_new_form1

UNION ALL

SELECT *
  
  FROM mta_old_to_new_form2;


INSERT 
  INTO mta_old_to_new_form

SELECT *
  
  FROM mta_old_to_new_form3;

-- ADD INDEXES
alter table mta_old_to_new_form add index (unit);
alter table mta_old_to_new_form add index (ca);
alter table mta_old_to_new_form add index (scp);
alter table mta_old_to_new_form add index (audit_date);
alter table mta_old_to_new_form add index (audit_time);
alter table mta_old_to_new_form add index (audit_day);

-- change string to DATE ( better for sorting!!! )
UPDATE mta_old_to_new_form
   SET audit_date = STR_TO_DATE(audit_date ,'%m-%d-%y');

-- ADD column for day of week
ALTER 
TABLE mta_old_to_new_form
  
  ADD COLUMN audit_day INT
AFTER audit_time;


-----------------------------------------
-- DAYOFWEEK(date)

-- Returns the weekday index for date (1 = Sunday, 2 = Monday, ., 7 = Saturday).
-- These index values correspond to the ODBC standard.

-----------------------------------------
UPDATE mta_old_to_new_form
   SET audit_day = DAYOFWEEK(audit_date) ;

-- UPDATE mta_new
-- SET audit_day = WEEKDAY(audit_date) ;

-----------------------------------------

-- CAN DO SIMILAR THING FOR "WEEK OF YEAR"


-----------------------------------------

ALTER 
TABLE mta_old_to_new_form
  
  ADD COLUMN audit_week INT
AFTER audit_day;

UPDATE mta_old_to_new_form
   SET audit_week = WEEK(audit_date) ;

-----------------------------------------

-- BRUNCH - SUNDAY - SATURDAY
--   11am - 5pm

	   -----------------------------------------
--  !!!!!!!         OBSERVED PROBLEM:       !!!!!!!!
       -----------------------------------------
-- 	some days only have 1 AUDIT in "burnch time period"
-- 				extended period to 5pm 
-----------------------------------------
-- SUNDAY
CREATE 
 TABLE long_sun_brunch_old

SELECT * 
  FROM mta_old_to_new_form

 WHERE audit_day = 1 
   AND audit_time >= '11:00:00' 
   AND audit_time <= '17:00:00';

-- SATURDAY
CREATE 
 TABLE long_sat_brunch_old

SELECT * 
  FROM mta_old_to_new_form

 WHERE audit_day = 7 
   AND audit_time >= '11:00:00' 
   AND audit_time <= '17:00:00';

-----------------------------------------

-- NITE LIFE - FRIDAY
--    8pm - 12am 
-- [ 20:00 - 24:00 ]

-----------------------------------------
-----------------------------------------
--  FRIDAY  NITE : 12 - 4am
-----------------------------------------
CREATE 
 TABLE friday_nite1_old

SELECT * 
  FROM mta_old_to_new_form
 
 WHERE audit_day = 6
   AND audit_time >= '20:00:00' 
   AND audit_time <= '24:00:00';

alter table friday_nite1_old add index (unit);
alter table friday_nite1_old add index (ca);
alter table friday_nite1_old add index (scp);
alter table friday_nite1_old add index (audit_date);
alter table friday_nite1_old add index (audit_day);
alter table friday_nite1_old add index (audit_week);

-----------------------------------------
--  FRIDAY  NITE : 8pm - 4am
-----------------------------------------
CREATE 
 TABLE friday_nite2_old

SELECT * 
  FROM mta_old_to_new_form

 WHERE audit_day = 7
   AND audit_time >= '00:00:00' 
   AND audit_time <= '04:00:00';

alter table friday_nite2_old add index (unit);
alter table friday_nite2_old add index (ca);
alter table friday_nite2_old add index (scp);
alter table friday_nite2_old add index (audit_date);
alter table friday_nite2_old add index (audit_day);
alter table friday_nite2_old add index (audit_week);
-----------------------------------------

-- NITE LIFE - SATURDAY
--    8pm - 12am 
-- [ 20:00 - 24:00 ]

-----------------------------------------
-----------------------------------------
--  SATURDAY  NITE : 8pm - 12
-----------------------------------------

CREATE 
 TABLE saturday_nite1_old

SELECT * 

  FROM mta_old_to_new_form
 WHERE audit_day = 7
   AND audit_time >= '20:00:00' 
   AND audit_time <= '24:00:00';

alter table saturday_nite1_old add index (unit);
alter table saturday_nite1_old add index (ca);
alter table saturday_nite1_old add index (scp);
alter table saturday_nite1_old add index (audit_date);
alter table saturday_nite1_old add index (audit_day);
alter table saturday_nite1_old add index (audit_week);


-----------------------------------------
--  SATURDAY  NITE : 12 - 4am
-----------------------------------------
CREATE 
 TABLE saturday_nite2_old


SELECT * 
  
  FROM mta_old_to_new_form
 WHERE audit_day = 1
   AND audit_time >= '00:00:00' 
   AND audit_time <= '04:00:00';

alter table saturday_nite2_old add index (unit);
alter table saturday_nite2_old add index (ca);
alter table saturday_nite2_old add index (scp);
alter table saturday_nite2_old add index (audit_date);
alter table saturday_nite2_old add index (audit_week);

-----------------------------------------
--  NOTE : adjust to 5pm end of day!!!!


-- 						   CUMULATIVE
-- BRUNCH - SUNDAY       ENTRIES / EXITS
-- BRUNCH - SATURDAY 
--   11am - 5pm			  BY TURNSTILE

-----------------------------------------

-----------------------------------------
--  SUNDAY BRUNCH
-----------------------------------------
CREATE 
 TABLE long_sun_cnts_by_turnstile_old

SELECT ca
     , unit
     , scp
     , audit_date
     , min(audit_time) as start_time
     , max(audit_time) as end_time     # start / end times
     , min(entries) as entry_start_cnt
     , max(entries) as entry_end_cnt   # start / end cnts
     , max(entries) - min(entries) as entry_period_cnt
     , min(exits) as exit_start_cnt
     , max(exits) as exit_end_cnt       # start / end cnts
     , max(exits) - min(exits) as exit_period_cnt

  FROM long_sun_brunch_old

 GROUP 
    BY unit
     , ca
     , scp
     , audit_date

 ORDER 
    BY unit
     , ca
     , scp
     , audit_date
     , audit_time;


CREATE 
 TABLE long_sat_cnts_by_turnstile_old

SELECT ca
     , unit
     , scp
     , audit_date
     , min(audit_time) as start_time
     , max(audit_time) as end_time     # start / end times
     , min(entries) as entry_start_cnt
     , max(entries) as entry_end_cnt # start / end cnts
     , max(entries) - min(entries) as entry_period_cnt
     , min(exits) as exit_start_cnt
     , max(exits) as exit_end_cnt       # start / end cnts
     , max(exits) - min(exits) as exit_period_cnt

  FROM long_sat_brunch_old

 GROUP 
    BY unit
     , ca
     , scp
     , audit_date
 ORDER 
    BY unit
     , ca
     , scp
     , audit_date
     , audit_time;


-----------------------------------------

-- 						   CUMULATIVE
-- NITE LIFE - FRIDAY    ENTRIES / EXITS
--    8pm - 12am 		  BY TURNSTILE
-- [ 20:00 - 24:00 ]
-----------------------------------------
-----------------------------------------
--  FRIDAY NITE
-----------------------------------------

CREATE
 TABLE fri_nite_cnts_by_turnstile_old

SELECT friday_nite1_old.ca
	 , friday_nite1_old.unit
	 , friday_nite1_old.scp
	 , friday_nite1_old.audit_date
   -- , friday_nite2_old.audit_date as second_date
	 , friday_nite1_old.audit_week 
	 , min(friday_nite1_old.audit_time) as start_time 
	 , max(friday_nite2_old.audit_time) as end_time
	 , min(friday_nite1_old.entries) as entry_start_cnt 
	 , max(friday_nite2_old.entries) as entry_end_cnt
	 , max(friday_nite2_old.entries) - min(friday_nite1_old.entries) as entry_period_cnt
	 , min(friday_nite1_old.exits) as exit_start_cnt
	 , max(friday_nite2_old.exits) as exit_end_cnt
	 , max(friday_nite2_old.exits) - min(friday_nite1_old.exits) as exit_period_cnt

  FROM friday_nite1_old 
  JOIN friday_nite2_old
    ON friday_nite1_old.unit = friday_nite2_old.unit
   AND friday_nite1_old.ca = friday_nite2_old.ca
   AND friday_nite1_old.scp = friday_nite2_old.scp
   -- AND friday_nite1_old.audit_week = friday_nite2_old.audit_week
   -- AND YEAR(friday_nite1_old.audit_date) = YEAR(friday_nite2_old.audit_date)
   AND DATEDIFF(friday_nite2_old.audit_date, friday_nite1_old.audit_date) = 1

 -- WHERE friday_nite1_old.unit = 'R029'    # for testing 
 --   AND friday_nite1_old.scp ='01-00-00'    # for testing 
-- AND friday_nite1_old.audit_week = 42    # for testing 

 GROUP 
	BY friday_nite1_old.unit
	 , friday_nite1_old.ca
	 , friday_nite1_old.scp
	 , friday_nite1_old.audit_date;

   LIMIT 20;


-----------------------------------------
--  SATURDAY NITE
-----------------------------------------

CREATE
 TABLE sat_nite_cnts_by_turnstile_old

SELECT saturday_nite1_old.ca
     , saturday_nite1_old.unit
     , saturday_nite1_old.scp
     , saturday_nite1_old.audit_date
     , saturday_nite1_old.audit_week
     , min(saturday_nite1_old.audit_time) as start_time
     , max(saturday_nite2_old.audit_time) as end_time
     , min(saturday_nite1_old.entries) as entry_start_cnt
     , max(saturday_nite2_old.entries) as entry_end_cnt
     , max(saturday_nite2_old.entries) - min(saturday_nite1_old.entries) as entry_period_cnt
	 , min(saturday_nite1_old.exits) as exit_start_cnt
	 , max(saturday_nite2_old.exits) as exit_end_cnt     
	 , max(saturday_nite2_old.exits) - min(saturday_nite1_old.exits) as exit_period_cnt

  FROM saturday_nite1_old 
  JOIN saturday_nite2_old

    ON saturday_nite1_old.unit = saturday_nite2_old.unit
   AND saturday_nite1_old.ca = saturday_nite2_old.ca
   AND saturday_nite1_old.scp = saturday_nite2_old.scp
   -- AND saturday_nite1_old.audit_week = ( saturday_nite2_old.audit_week - 1 )
   -- AND YEAR(saturday_nite1_old.audit_date) = YEAR(saturday_nite2_old.audit_date)
   AND DATEDIFF(saturday_nite2_old.audit_date, saturday_nite1_old.audit_date) = 1

 -- WHERE saturday_nite1.unit = 'R029'    # for testing 
   -- AND saturday_nite1.scp ='01-00-00'  # for testing 
   -- AND saturday_nite1.audit_week = 42  # for testing 

 GROUP 
    BY saturday_nite1_old.unit
     , saturday_nite1_old.ca
     , saturday_nite1_old.scp
     , saturday_nite1_old.audit_date;
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
 TABLE long_sun_cnts_by_station_old

SELECT unit
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM long_sun_cnts_by_turnstile_old
-- WHERE ( audit_date = '2014-11-02' OR audit_date = '2014-11-09') 	# for testing 

 GROUP 
    BY unit
     , audit_date

 ORDER 
    BY unit
     , audit_date;

-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------


CREATE 
 TABLE long_sat_cnts_by_station_old

SELECT unit
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM long_sat_cnts_by_turnstile_old
-- WHERE ( audit_date = '2014-11-01' OR audit_date = '2014-11-08') 	# for testing 
 GROUP 
    BY unit
     , audit_date

 ORDER 
    BY unit
     , audit_date;

-----------------------------------------
--  FRIDAY NITE
-----------------------------------------

CREATE 
 TABLE fri_nite_cnts_by_station_old

SELECT unit
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM fri_nite_cnts_by_turnstile_old
 -- WHERE ( audit_date = '2014-10-31' OR audit_date = '2014-10-24') 	# for testing 

 GROUP 
    BY unit
     , audit_date

 ORDER 
    BY unit
     , audit_date;

-----------------------------------------
--  SATURDAY NITE
-----------------------------------------

CREATE 
 TABLE sat_nite_cnts_by_station_old

SELECT unit
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM sat_nite_cnts_by_turnstile_old
-- WHERE ( audit_date = '2014-11-01' OR audit_date = '2014-11-08') 	# for testing 

 GROUP 
    BY unit
     , audit_date

 ORDER 
    BY unit
     , audit_date;
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
 TABLE long_sun_total_cnts_old

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM long_sun_cnts_by_station_old
-- WHERE ( audit_date = '2014-11-02' ) 	# for testing 
 GROUP 
    BY audit_date;

-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------
CREATE 
 TABLE long_sat_total_cnts_old

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM long_sat_cnts_by_station_old
-- WHERE ( audit_date = '2014-11-01' ) 	# for testing 
 GROUP 
    BY audit_date;


-----------------------------------------
--  FRIDAY NITE
-----------------------------------------
CREATE 
 TABLE fri_nite_total_cnts_old

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM fri_nite_cnts_by_station_old
-- WHERE ( audit_date = '2014-11-02' ) 	# for testing 
 GROUP 
    BY audit_date;

-----------------------------------------
--  SATURDAY NITE
-----------------------------------------
CREATE 
 TABLE sat_nite_total_cnts_old

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM sat_nite_cnts_by_station_old
-- WHERE ( audit_date = '2014-11-02' ) 	# for testing 
 GROUP 
    BY audit_date;
-----------------------------------------

-- 						  PROPORTION OF 
-- BRUNCH - SUNDAY       ENTRIES / EXITS
-- BRUNCH - SATURDAY 
--   11am - 5pm				BY DATE

-----------------------------------------

-- ALL UNIT VALUES!!! 463 stations
CREATE 
 TABLE station_list_old

SELECT DISTINCT(unit) 
  FROM long_sun_brunch_old;

-----------------------------------------
--  SUNDAY BRUNCH --  ALL DATES: 
-----------------------------------------
CREATE 
 TABLE sun_date_list_old

SELECT DISTINCT(audit_date) 
  FROM long_sun_brunch_old;

-----------------------------------------
--  SATURDAY  --  ALL DATES: 
-----------------------------------------
CREATE 
 TABLE sat_date_list_old

SELECT DISTINCT(audit_date) 
  FROM long_sat_brunch_old;

-----------------------------------------
--  FRIDAY NITE --  ALL DATES: 
-----------------------------------------
CREATE 
 TABLE fri_date_list_old

SELECT DISTINCT(audit_date) 
  FROM friday_nite1_old;


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


