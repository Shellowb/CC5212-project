/**
*
* we first get the data:
* The fisrt option is likely as it follows:
* get the number of countries
* for each country get is AVG (of avg's) temperature
* generate square (x - avg)²
* sum (x_i - avg)²
* division (sum/n)
* get STDDEV (SQRT(division))
*
* we first get the data:
* get the year for each date
* get the maximum T° by city for each year
* get the minimum T° by city for each year
* generate (max-min)
* 
*/



-- Load the City data
cities = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCity.csv' USING PigStorage(',')
AS (date:datetime, avg:float, avgu:float, city:chararray, country:chararray,  la:chararray, lo:chararray);


-- Get year by date
cities = FOREACH cities GENERATE GetYear(date) AS year, avg AS avg, city AS city, country AS country;

-- GET THE MAX AND MIN OVER THE YEARS.

-- Group by city and year
group_city_year = GROUP cities BY (city, country, year);

-- For each city get min and max by year
max_min = FOREACH group_city_year GENERATE FLATTEN($0) AS (city, country, year), MIN($1.avg) AS min_T, MAX($1.avg) AS max_T;

delta_T_by_city = FOREACH max_min GENERATE (max_T - min_T) AS delta_T, city AS city, country AS country, year AS year;

STORE delta_T_by_city into '/uhadoop2020/uhadoop2020/grupo08/project/';