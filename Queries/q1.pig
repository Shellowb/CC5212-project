/**
* Before anything, we what to clarify that the affection is in terms of the delta in T° and not by other social, economical or other humanas factors that ae not considered in this study.
* There are two ways to answer this question, first is to get the STDDEV of the avg temperature per country and just say that the countries that have a a bigger STDDEV are more affected by the changes in temperature.
* This way have some limitations, for example, those countries in which the T° fluctuates more than others will have a greater STDDEV than others in wich the temperature is more stable.
* Another way a bit more accurate is to compare, the delta between years and observate the evolution of the change in deltas over the years.
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
* get the data
* 
*/



-- Load the Country data
/*test
country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/country_reduced.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);
*/
countries = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCountry.csv' USING PigStorage(',') AS (date:datetime, avg:float, avgu:float, country:chararray);

-- GET THE STANDARD DEV OVER THE YEARS.

-- For each country generate average
countries_by_year = FOREACH countries GENERATE GetYear(date) AS year, avg AS avg, country AS country;
group_contries_year = GROUP countries_by_year BY (country, year);
year_avg_country = FOREACH group_contries_year GENERATE FLATTEN($0) AS (country, year), AVG($1.avg) AS yearly_average;

STORE year_avg_country INTO 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/avgc';
year_avg_per_country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/avgc/part-r-00000'
                  AS (country: chararray, year: int, yavg: float);

-- generate square (x - avg)²
filter_avg_per_country = FILTER year_avg_per_country BY yavg > 0;
filter_year_avg_country = FILTER filter_avg_per_country BY year > 0;
xi = JOIN filter_year_avg_country BY country, countries_by_year BY country;
xj = FOREACH xi GENERATE $0 AS country, $1 AS year, $2 AS yavg, $4 as avg;
square_per_country = FOREACH xj GENERATE country, year, (yavg - avg)*(yavg - avg) AS sq;

-- sum (x_i - avg)²
g_to_sum = GROUP square_per_country BY country;
sumatory = FOREACH g_to_sum GENERATE $0 AS country, SUM($1.sq) AS s;

-- number of avg per country by years
n = FOREACH group_contries_year GENERATE flatten($0) AS (country, year), COUNT($1.avg) AS count;

-- filter
-- n = FOREACH group_per_country GENERATE flatten($0) AS country, COUNT($1.avg) AS count;
/*number_of_countries = FILTER n BY count > 1;
sumatory = FILTER sumatory BY $1 is not null;*/

STORE n into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/n_countries_yearly';
STORE sumatory into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/sum_temp_yearly';

n_countries = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/n_countries_yearly/part-r-00000' USING PigStorage('\t')
AS (country: chararray, year: int, count: int);
sumatory_coutries = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/sum_temp_yearly/part-r-00000' USING PigStorage('\t')
AS (country: chararray, year: int, count: double);

-- division
n_sumatory = JOIN sumatory_coutries BY country, n_countries BY country; --- Error DESCONOCIDO;
division = FOREACH n_sumatory GENERATE $0 AS country, year, (float)($1/$3) AS div;

-- GET STDDEV
std = FOREACH division GENERATE country, year, SQRT(div) as std;

STORE std into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/std_by_year';

-- avg std
group_std_country = GROUP std BY country;
std_year_avg = FOREACH group_std_country GENERATE flatten($0) AS country, AVG($1.std) AS avg_years;

STORE std_year_avg into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/std_by_year_avg';
std_years_avg = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/std_by_year_avg' USING PigStorage('\t')
                AS (country: chararray, avg: double);

-- std
si = JOIN std_years_avg BY country, std BY country;
sj = FOREACH si GENERATE $0 AS country, $1 AS year, $2 AS yavg, $4 as avg;
square_std_country = FOREACH xj GENERATE country, year, (yavg - avg)*(yavg - avg) AS sq;

-- number of countries
n_std = FOREACH group_std_country GENERATE flatten($0) AS (country, year), COUNT($1.std) AS count;

--
g_std_sum = GROUP square_std_country BY country;
std_sumatory = FOREACH g_std_sum GENERATE $0 AS country, SUM($1.sq) AS s;

STORE n_std into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/n_std_countries';
STORE sumatory into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/sum_std_temp';

n_std_c = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/n_std_countries/part-r-00000' USING PigStorage('\t')
AS (country: chararray, year: int, count: int);
c_sumatory_std = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/sum_std_temp/part-r-00000' USING PigStorage('\t')
AS (country: chararray, year: int, count: double);

-- division
n_s = JOIN c_sumatory_std BY country, n_std_c BY country; --- Error DESCONOCIDO;
std_division = FOREACH n_s GENERATE $0 AS country, year, (float)($1/$3) AS div;

-- GET STDDEV
std_std = FOREACH std_division GENERATE country, year, SQRT(div) as std;

STORE std_std into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/std_std';