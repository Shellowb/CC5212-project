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

-- For each city get average by year
averages_cities = FOREACH group_city_year GENERATE FLATTEN($0) AS (city, country, year), AVG($1.avg) AS yearly_average;

STORE averages_cities into '/uhadoop2020/uhadoop2020/grupo08/project/';