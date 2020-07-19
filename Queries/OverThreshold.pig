-- Load the Country data
countries = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCountry.csv' USING PigStorage(',')
AS (date:chararray, avg, avgu, country);

-- get only the years
fixyear = FOREACH countries GENERATE SUBSTRING(date, 0, 4) AS (year:int), avg, country;

-- filter
--filt = FILTER fixyear BY avg > $threshold;
filt = FILTER fixyear BY avg > 35;

grp = GROUP filt BY (year, country);

over_threshold = FOREACH grp GENERATE flatten($0), COUNT($1) as count;

STORE over_threshold into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/';


