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

-- C/A,UNIT,SCP,STATION,LINENAME,DIVISION,DATE,TIME,DESC,ENTRIES,EXITS


-- C/A      = Control Area (A002)
-- UNIT     = Remote Unit for a station (R051)
-- SCP      = Subunit Channel Position represents an specific address for a device (02-00-00)
-- STATION  = Represents the station name the device is located at
-- LINENAME = Represents all train lines that can be boarded at this station
--            Normally lines are represented by one character.  LINENAME 456NQR repersents train server for 4, 5, 6, N, Q, and R trains.
-- DIVISION = Represents the Line originally the station belonged to BMT, IRT, or IND   
-- DATE     = Represents the date (MM-DD-YY)
-- TIME     = Represents the time (hh:mm:ss) for a scheduled audit event
-- DESc     = Represent the "REGULAR" scheduled audit event (Normally occurs every 4 hours)
--            1. Audits may occur more that 4 hours due to planning, or troubleshooting activities. 
--            2. Additionally, there may be a "RECOVR AUD" entry: This refers to a missed audit that was recovered. 
-- ENTRIES  = The comulative entry register value for a device
-- EXIST    = The cumulative exit register value for a device


CREATE 
 TABLE mta_new(
	ca VARCHAR(255),
	unit VARCHAR(255),
	scp VARCHAR(255),
	station VARCHAR(255),
	linename VARCHAR(255),
	division VARCHAR(255),
	audit_date VARCHAR(255),
	audit_time TIME,
	description VARCHAR(255),
	entries INT,
	exits INT
);


-- LOAD file names into LIST; CONCAT list 
ls  *_15*txt  *_1412*txt *_1411*txt *_14102*txt *_141018.txt > new_format_list.txt
cat new_format_list.txt | xargs tail -n+2 > ALLNEW.txt

--  LOAD file DATA into TABLE: MySQL
LOAD DATA LOCAL INFILE "ALLNEW.txt"
    INTO TABLE mta_new FIELDS TERMINATED BY "," IGNORE 1 LINES;

-- change string to DATE ( better for sorting!!! )
UPDATE mta_new
SET audit_date = STR_TO_DATE(audit_date ,'%m/%d/%Y');

-- ADD column for day of week
ALTER TABLE mta_new
ADD COLUMN audit_day INT
AFTER audit_time;

-----------------------------------------
-- DAYOFWEEK(date)

-- Returns the weekday index for date (1 = Sunday, 2 = Monday, ., 7 = Saturday).
-- These index values correspond to the ODBC standard.

-----------------------------------------
UPDATE mta_new
SET audit_day = DAYOFWEEK(audit_date) ;

-- UPDATE mta_new
-- SET audit_day = WEEKDAY(audit_date) ;

-----------------------------------------

-- CAN DO SIMILAR THING FOR "WEEK OF YEAR"


-----------------------------------------

ALTER TABLE mta_new
ADD COLUMN audit_week INT
AFTER audit_day;

UPDATE mta_new
SET audit_week = WEEK(audit_date) ;

-----------------------------------------

-- CAN DO SIMILAR THING FOR "YEAR"


-----------------------------------------

ALTER TABLE long_sat_brunch
ADD COLUMN audit_year INT
AFTER audit_week;

UPDATE long_sat_brunch
SET audit_year = YEAR(audit_date) ;

-----------------------------------------

-- BRUNCH - SUNDAY - SATURDAY
--   11am - 5pm

	   -----------------------------------------
--  !!!!!!!         OBSERVED PROBLEM:       !!!!!!!!
       -----------------------------------------
-- 	some days only have 1 AUDIT in "burnch time period"
-- 				extended period to 5pm 
-----------------------------------------
CREATE 
 TABLE sun_brunch

SELECT * 
 
  FROM mta_new
 
 WHERE audit_day = 1 
   AND audit_time >= '11:00:00' 
   AND audit_time <= '16:00:00';

alter table sun_brunch add index (unit);
alter table sun_brunch add index (ca);
alter table sun_brunch add index (scp);
alter table sun_brunch add index (audit_date);


-----------------------------------------
--  SUNDAY BRUNCH
-----------------------------------------

CREATE 
 TABLE long_sun_brunch

SELECT * 

  FROM mta_new

 WHERE audit_day = 1 
   AND audit_time >= '11:00:00' 
   AND audit_time <= '17:00:00';

alter table long_sun_brunch add index (unit);
alter table long_sun_brunch add index (ca);
alter table long_sun_brunch add index (scp);
alter table long_sun_brunch add index (audit_date);
-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------
CREATE 
 TABLE long_sat_brunch

SELECT * 
  FROM mta_new
 
 WHERE audit_day = 7 
   AND audit_time >= '11:00:00' 
   AND audit_time <= '17:00:00';

alter table long_sat_brunch add index (unit);
alter table long_sat_brunch add index (ca);
alter table long_sat_brunch add index (scp);
alter table long_sat_brunch add index (audit_date);

-----------------------------------------

-- NITE LIFE - FRIDAY
--    8pm - 12am 
-- [ 20:00 - 24:00 ]

-----------------------------------------
-----------------------------------------
--  FRIDAY  NITE : 8pm - 12
-----------------------------------------

CREATE 
 TABLE friday_nite1

SELECT * 

  FROM mta_new
 WHERE audit_day = 6
   AND audit_time >= '20:00:00' 
   AND audit_time <= '24:00:00';

alter table friday_nite1 add index (unit);
alter table friday_nite1 add index (ca);
alter table friday_nite1 add index (scp);
alter table friday_nite1 add index (audit_date);

-----------------------------------------
--  FRIDAY  NITE : 12 - 4am
-----------------------------------------
CREATE 
 TABLE friday_nite2

SELECT * 
  
  FROM mta_new
 WHERE audit_day = 7
   AND audit_time >= '00:00:00' 
   AND audit_time <= '04:00:00';

alter table friday_nite2 add index (unit);
alter table friday_nite2 add index (ca);
alter table friday_nite2 add index (scp);
alter table friday_nite2 add index (audit_date);


-----------------------------------------

-- NITE LIFE - SATURDAY
--    8pm - 12am 
-- [ 20:00 - 24:00 ]

-----------------------------------------
-----------------------------------------
--  SATURDAY  NITE : 8pm - 12
-----------------------------------------

CREATE 
 TABLE saturday_nite1

SELECT * 

  FROM mta_new
 WHERE audit_day = 7
   AND audit_time >= '20:00:00' 
   AND audit_time <= '24:00:00';

alter table saturday_nite1 add index (unit);
alter table saturday_nite1 add index (ca);
alter table saturday_nite1 add index (scp);
alter table saturday_nite1 add index (audit_date);


-----------------------------------------
--  SATURDAY  NITE : 12 - 4am
-----------------------------------------
CREATE 
 TABLE saturday_nite2


SELECT * 
  
  FROM mta_new
 WHERE audit_day = 1
   AND audit_time >= '00:00:00' 
   AND audit_time <= '04:00:00';

alter table saturday_nite2 add index (unit);
alter table saturday_nite2 add index (ca);
alter table saturday_nite2 add index (scp);
alter table saturday_nite2 add index (audit_date);


-----------------------------------------

-- BRUNCH - SUNDAY - SATURDAY
--   11am - 5pm

	   -----------------------------------------
--  !!!!!!!         OBSERVED PROBLEM:       !!!!!!!!
       -----------------------------------------
-- 	some days only have 1 AUDIT in "burnch time period"
-- 				extended period to 5pm 
-----------------------------------------


-- one station - one Sunday
SELECT * 
  from long_sun_brunch 
 WHERE unit = 'R001' 
   AND audit_date = '2014-10-12';

SELECT * 
  from long_sun_brunch 
 WHERE unit = 'R092' 
   AND audit_date = '2014-10-26';


SELECT * 
  from long_sat_brunch 
 WHERE unit = 'R001' 
   AND audit_date = '2014-10-11';

SELECT * 
  from long_sat_brunch 
 WHERE unit = 'R092' 
   AND audit_date = '2014-10-25';
--  OBSERVED PROBLEM: some days only have 1 AUDIT in "burnch time period"


-- SELECT ALL date / time combos for STATION:
SELECT * 

  from long_sun_brunch 
 WHERE unit = 'R001'

 GROUP 
    BY audit_date
     , audit_time;



SELECT * 

  from long_sat_brunch 
 WHERE unit = 'R001'

 GROUP 
    BY audit_date
     , audit_time;


-----------------------------------------
--  NOTE :    MISSING friday nite  10/10/14  (in OLD MTA DATA)

-- | A060 | R001 | 00-00-00 | WHITEHALL ST | R1       | BMT      | 2014-10-11 | 01:00:00   |         7 |         40 | REGULAR     |  805439 | 1141080 |


-- NITE LIFE - FRIDAY
--    8pm - 12am 
-- [ 20:00 - 24:00 ]

-----------------------------------------
-- one station - one Friday part 1
SELECT * from friday_nite1 WHERE unit = 'R001' AND audit_date = '2014-10-31';
SELECT * from friday_nite1 WHERE unit = 'R092' AND audit_date = '2014-10-24';

-- one station - one Friday part 2
SELECT * from friday_nite2 WHERE unit = 'R001' AND audit_date = '2014-11-01';
SELECT * from friday_nite2 WHERE unit = 'R092' AND audit_date = '2014-10-25';

SELECT * from friday_nite_all WHERE unit = 'R001' AND (audit_date = '2014-10-31' OR audit_date = '2014-11-01');
SELECT * from friday_nite_all WHERE unit = 'R001' AND (audit_date = '2014-10-24' OR audit_date = '2014-10-25'); 



-- SELECT ALL date / time combos for STATION:
SELECT * from friday_nite1 WHERE unit = 'R001'
GROUP BY audit_date, audit_time;

-- SELECT ALL date / time combos for STATION:
SELECT * from friday_nite2 WHERE unit = 'R001'
GROUP BY audit_date, audit_time;

-- SELECT ALL date / time combos for STATION: 
--     [     friday    &    saturday     ]
SELECT * from friday_nite_all WHERE unit = 'R001'
GROUP BY audit_date, audit_time;

-----------------------------------------

-- NITE LIFE - SATURDAY
--    8pm - 12am 
-- [ 20:00 - 24:00 ]

-----------------------------------------
-- one station - one Saturday part 1
SELECT * from saturday_nite1 WHERE unit = 'R001' AND audit_date = '2014-11-01';
SELECT * from saturday_nite1 WHERE unit = 'R092' AND audit_date = '2014-10-25';

-- one station - one Saturday part 2
SELECT * from saturday_nite2 WHERE unit = 'R001' AND audit_date = '2014-11-02';
SELECT * from saturday_nite2 WHERE unit = 'R092' AND audit_date = '2014-10-26';

SELECT * from saturday_nite_all WHERE unit = 'R001' AND (audit_date = '2014-11-01' OR audit_date = '2014-11-02');
SELECT * from saturday_nite_all WHERE unit = 'R001' AND (audit_date = '2014-10-25' OR audit_date = '2014-10-26'); 

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
--  MIN & MAX entries / EXITS for 1 turnstile
SELECT ca
	 , unit
	 , scp
	 , station
	 , linename
	 , audit_date
	 , entries
	 , exits
	 , min(audit_time) as start_time
	 , max(audit_time) as end_time 
	 , min(entries) as entry_start_cnt
	 , max(entries) as entry_end_cnt
	 , max(entries) - min(entries) as entry_period_cnt
  FROM long_sun_brunch 
 WHERE unit = 'R001' # for testing 
   AND scp ='01-00-00' # for testing 
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
     , audit_time
 LIMIT 50;
-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------
SELECT ca
     , unit
     , scp
     , station
     , linename
     , audit_date
     , entries
     , exits
     , min(audit_time) as start_time
     , max(audit_time) as end_time 
     , min(entries) as entry_start_cnt
     , max(entries) as entry_end_cnt
     , max(entries) - min(entries) as entry_period_cnt
  FROM long_sat_brunch 
 WHERE unit = 'R001' # for testing 
   AND scp ='01-00-00' # for testing 
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
	, audit_time
 LIMIT 50;

-----------------------------------------

-- NITE LIFE - FRIDAY
--    8pm - 12am 	-----	TESTING ----
-- [ 20:00 - 24:00 ]

-----------------------------------------
--  START TIMES
SELECT *
	 , min(audit_time)

  FROM friday_nite1 
 WHERE unit = 'R001' # for testing 
   AND scp ='01-00-00' # for testing 
   AND audit_week = 42
 
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
    , audit_time
 
 LIMIT 50;

--  END TIMES
SELECT *
     , max(audit_time)
 
  FROM friday_nite2
 WHERE unit = 'R001' # for testing 
   AND scp ='01-00-00' # for testing 
   AND audit_week = 42
 
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
     , audit_time
 
 LIMIT 50;


--  MIN entries / EXITS for 1 turnstile
SELECT friday_nite1.ca
     , friday_nite1.unit
     , friday_nite1.scp
     , friday_nite1.station
     , friday_nite1.linename
     , friday_nite1.audit_date
     , friday_nite1.audit_week
     , min(friday_nite1.audit_time) as start_time
     , min(friday_nite1.entries) as entry_start_cnt
     , max(friday_nite2.audit_time) as end_time
     , max(friday_nite2.entries) as entry_end_cnt
     , max(friday_nite2.entries) - min(friday_nite1.entries) as entry_period_cnt
	 , min(friday_nite1.exits) as exit_start_cnt
	 , max(friday_nite2.exits) as exit_end_cnt     
	 , max(friday_nite2.exits) - min(friday_nite1.exits) as exit_period_cnt

  FROM friday_nite1 
  JOIN friday_nite2

    ON friday_nite1.unit = friday_nite2.unit
   AND friday_nite1.ca = friday_nite2.ca
   AND friday_nite1.scp = friday_nite2.scp
   AND friday_nite1.audit_week = friday_nite2.audit_week

 WHERE friday_nite1.unit = 'R029' # for testing 
-- AND friday_nite1.scp ='01-00-00' # for testing 
   AND friday_nite1.audit_week = 42

 GROUP 
    BY friday_nite1.unit
     , friday_nite1.ca
     , friday_nite1.scp
     , friday_nite1.audit_date
 LIMIT 20;


--  MIN entries / EXITS for 1 turnstile
SELECT saturday_nite1.ca
     , saturday_nite1.unit
     , saturday_nite1.scp
     , saturday_nite1.station
     , saturday_nite1.linename
     , saturday_nite1.audit_date
     , saturday_nite1.audit_week
     , min(saturday_nite1.audit_time) as start_time
     , min(saturday_nite1.entries) as entry_start_cnt
     , max(saturday_nite2.audit_time) as end_time
     , max(saturday_nite2.entries) as entry_end_cnt
     , max(saturday_nite2.entries) - min(saturday_nite1.entries) as entry_period_cnt
	 , min(saturday_nite1.exits) as exit_start_cnt
	 , max(saturday_nite2.exits) as exit_end_cnt     
	 , max(saturday_nite2.exits) - min(saturday_nite1.exits) as exit_period_cnt

  FROM saturday_nite1 
  JOIN saturday_nite2

    ON saturday_nite1.unit = saturday_nite2.unit
   AND saturday_nite1.ca = saturday_nite2.ca
   AND saturday_nite1.scp = saturday_nite2.scp
   AND saturday_nite1.audit_week = ( saturday_nite2.audit_week - 1 )

 WHERE saturday_nite1.unit = 'R029' # for testing 
-- AND saturday_nite1.scp ='01-00-00' # for testing 
   AND saturday_nite1.audit_week = 42

 GROUP 
    BY saturday_nite1.unit
     , saturday_nite1.ca
     , saturday_nite1.scp
     , saturday_nite1.audit_date
 LIMIT 20;

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
 TABLE long_sun_cnts_by_turnstile

SELECT ca
     , unit
     , scp
     , station
     , linename
     , audit_date
     , min(audit_time) as start_time
     , max(audit_time) as end_time 
     , min(entries) as entry_start_cnt    # start / end times
     , max(entries) as entry_end_cnt      # start / end cnts
     , max(entries) - min(entries) as entry_period_cnt
     , min(exits) as exit_start_cnt
     , max(exits) as exit_end_cnt       # start / end cnts
     , max(exits) - min(exits) as exit_period_cnt

  FROM long_sun_brunch 
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
--  SATURDAY BRUNCH
-----------------------------------------

CREATE 
 TABLE long_sat_cnts_by_turnstile

SELECT ca
	 , unit
	 , scp
	 , station
	 , linename
	 , audit_date
	 , min(audit_time) as start_time
	 , max(audit_time) as end_time     # start / end times
	 , min(entries) as entry_start_cnt
	 , max(entries) as entry_end_cnt # start / end cnts
	 , max(entries) - min(entries) as entry_period_cnt
	 , min(exits) as exit_start_cnt
	 , max(exits) as exit_end_cnt       # start / end cnts
	 , max(exits) - min(exits) as exit_period_cnt
  FROM long_sat_brunch 
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
 TABLE fri_nite_cnts_by_turnstile

SELECT friday_nite1.ca
	 , friday_nite1.unit
	 , friday_nite1.scp
	 , friday_nite1.station
	 , friday_nite1.linename
	 , friday_nite1.audit_date
	 , friday_nite1.audit_week 
	 , min(friday_nite1.audit_time) as start_time 
	 , max(friday_nite2.audit_time) as end_time
	 , min(friday_nite1.entries) as entry_start_cnt 
	 , max(friday_nite2.entries) as entry_end_cnt
	 , max(friday_nite2.entries) - min(friday_nite1.entries) as entry_period_cnt
	 , min(friday_nite1.exits) as exit_start_cnt
	 , max(friday_nite2.exits) as exit_end_cnt
	 , max(friday_nite2.exits) - min(friday_nite1.exits) as exit_period_cnt

  FROM friday_nite1 
  JOIN friday_nite2
	ON friday_nite1.unit = friday_nite2.unit
   AND friday_nite1.ca = friday_nite2.ca
   AND friday_nite1.scp = friday_nite2.scp
   -- AND friday_nite1.audit_week = friday_nite2.audit_week
   AND DATEDIFF(friday_nite2.audit_date, friday_nite1.audit_date) = 1

-- WHERE friday_nite1.unit = 'R029'    # for testing 
-- AND friday_nite1.scp ='01-00-00'    # for testing 
-- AND friday_nite1.audit_week = 42    # for testing 

 GROUP 
	BY friday_nite1.unit
	 , friday_nite1.ca
	 , friday_nite1.scp
	 , friday_nite1.audit_date;

-----------------------------------------
--  SATURDAY NITE
-----------------------------------------

CREATE
 TABLE sat_nite_cnts_by_turnstile

SELECT saturday_nite1.ca
     , saturday_nite1.unit
     , saturday_nite1.scp
     , saturday_nite1.station
     , saturday_nite1.linename
     , saturday_nite1.audit_date
     , saturday_nite1.audit_week
     , min(saturday_nite1.audit_time) as start_time
     , max(saturday_nite2.audit_time) as end_time
     , min(saturday_nite1.entries) as entry_start_cnt
     , max(saturday_nite2.entries) as entry_end_cnt
     , max(saturday_nite2.entries) - min(saturday_nite1.entries) as entry_period_cnt
	 , min(saturday_nite1.exits) as exit_start_cnt
	 , max(saturday_nite2.exits) as exit_end_cnt     
	 , max(saturday_nite2.exits) - min(saturday_nite1.exits) as exit_period_cnt

  FROM saturday_nite1 
  JOIN saturday_nite2

    ON saturday_nite1.unit = saturday_nite2.unit
   AND saturday_nite1.ca = saturday_nite2.ca
   AND saturday_nite1.scp = saturday_nite2.scp
   -- AND saturday_nite1.audit_week = ( saturday_nite2.audit_week - 1 )
   AND DATEDIFF(saturday_nite2.audit_date, saturday_nite1.audit_date) = 1

 -- WHERE saturday_nite1.unit = 'R029'    # for testing 
   -- AND saturday_nite1.scp ='01-00-00'  # for testing 
   -- AND saturday_nite1.audit_week = 42  # for testing 

 GROUP 
    BY saturday_nite1.unit
     , saturday_nite1.ca
     , saturday_nite1.scp
     , saturday_nite1.audit_date;

-----------------------------------------

-- 						   CUMULATIVE
-- BRUNCH - SUNDAY       ENTRIES / EXITS
-- BRUNCH - SATURDAY 
--   11am - 5pm			   BY STATION 

-----------------------------------------
-----------------------------------------
--  SUNDAY BRUNCH - TESTING 
-----------------------------------------
-- TEST for one station ( unit = 'R001' ) - BY control area ( 3 ca for 'R001' )
SELECT unit
     , ca
     , station
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM long_sun_cnts_by_turnstile
 
 WHERE unit = 'R001'                                            # for testing 
   AND ( audit_date = '2014-11-02' OR audit_date = '2014-11-09')  # for testing 
-- AND ( scp ='01-00-00' OR scp = '01-00-01' )                 # for testing 

 GROUP 
    BY unit
     , ca
     , audit_date
 
 ORDER 
    BY unit
     , ca
     , audit_date;


-----------------------------------------
--  SATURDAY BRUNCH - TESTING 
-----------------------------------------
-- TEST for one station ( unit = 'R001' ) - BY control area ( 3 ca for 'R001' )

SELECT unit
     , ca
     , station
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM long_sat_cnts_by_turnstile
 WHERE unit = 'R001'                                            # for testing 
   AND ( audit_date = '2014-11-01' OR audit_date = '2014-11-08')  # for testing 
-- AND ( scp ='01-00-00' OR scp = '01-00-01' )                 # for testing 

 GROUP 
    BY unit
     , ca
     , audit_date

 ORDER 
    BY unit
     , ca
     , audit_date;
-----------------------------------------
--  SUNDAY BRUNCH
-----------------------------------------

-- CREATE TABLE FOR ALL STATIONS ( id = unit )
CREATE 
 TABLE long_sun_cnts_by_station

SELECT unit
     , station
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM long_sun_cnts_by_turnstile
-- WHERE ( audit_date = '2014-11-02' OR audit_date = '2014-11-09') 	# for testing 

 GROUP 
    BY unit
     , audit_date

 ORDER 
    BY unit
     , audit_date;
-- LIMIT 100; 														# for testing 

-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------


CREATE 
 TABLE long_sat_cnts_by_station

SELECT unit
     , station
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM long_sat_cnts_by_turnstile
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
 TABLE fri_nite_cnts_by_station

SELECT unit
     , station
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM fri_nite_cnts_by_turnstile
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
 TABLE sat_nite_cnts_by_station

SELECT unit
     , station
     , audit_date
     , sum(entry_period_cnt) as station_entry_total_cnt
     , sum(exit_period_cnt) as station_exit_total_cnt

  FROM sat_nite_cnts_by_turnstile
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
 TABLE long_sun_total_cnts

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM long_sun_cnts_by_station
-- WHERE ( audit_date = '2014-11-02' ) 	# for testing 
 GROUP 
    BY audit_date;

-----------------------------------------
--  SATURDAY BRUNCH
-----------------------------------------
CREATE 
 TABLE long_sat_total_cnts

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM long_sat_cnts_by_station
-- WHERE ( audit_date = '2014-11-01' ) 	# for testing 
 GROUP 
    BY audit_date;

-----------------------------------------
--  FRIDAY NITE
-----------------------------------------
CREATE 
 TABLE fri_nite_total_cnts

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM fri_nite_cnts_by_station
-- WHERE ( audit_date = '2014-11-02' ) 	# for testing 
 GROUP 
    BY audit_date;

-----------------------------------------
--  SATURDAY NITE
-----------------------------------------
CREATE 
 TABLE sat_nite_total_cnts

SELECT audit_date
	 , sum(station_entry_total_cnt) AS total_day_entries
	 , sum(station_exit_total_cnt) AS total_day_exits

  FROM sat_nite_cnts_by_station
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
CREATE TABLE station_list
SELECT DISTINCT(unit) from sun_brunch;

-----------------------------------------
--  SUNDAY BRUNCH --  ALL DATES: 
-----------------------------------------
CREATE TABLE sun_date_list
SELECT DISTINCT(audit_date) from sun_brunch;

-----------------------------------------
--  SATURDAY  --  ALL DATES: 
-----------------------------------------
CREATE TABLE sat_date_list
SELECT DISTINCT(audit_date) from long_sat_brunch;

-----------------------------------------
--  FRIDAY NITE --  ALL DATES: 
-----------------------------------------
CREATE TABLE fri_date_list
SELECT DISTINCT(audit_date) from friday_nite1;



-- AUDIT DATES & TIMES for 1 station
SELECT ca, unit, scp, audit_date, audit_time, entries, exits from sun_brunch 
WHERE unit = 'R001'
AND scp = '00-00-01'
GROUP BY unit, ca, scp, audit_date, audit_time ;



-----------------------------------------

-- for TESTING!!!!

-----------------------------------------
--  LOAD file DATA into TABLE: MySQL
LOAD DATA LOCAL INFILE "turnstile_141018.txt"
    INTO TABLE test_mta_new FIELDS TERMINATED BY "," IGNORE 1 LINES;



UPDATE test_mta_new
SET audit_date = SELECT STR_TO_DATE(audit_date ,'%m/%d/%y') FROM test_mta_new ;

SELECT

-- Records: 3995401  Deleted: 0  Skipped: 0  Warnings: 402


---------------------------------------------------------
-- DISTINCT STATIONS!!!! 

-- mysql> SELECT COUNT(DISTINCT unit) FROM mta_new;
-- +----------------------+
-- | COUNT(DISTINCT unit) |
-- +----------------------+
-- |                  463 |
-- +----------------------+



cursor = db.cursor()

cursor.execute("SELECT * FROM french_men_2013")
for i in cursor.fetchall():
    print i

cursor.close()
db.close()


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



