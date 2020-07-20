-- Load the Country data
/*test
country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/country_reduced.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);
*/
country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCountry.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);

-- GET THE STANDARD DEV OVER THE YEARS.

-- For each country generate average
group_per_country = GROUP country BY country;
avg_per_country = FOREACH group_per_country GENERATE flatten($0) AS country, AVG($1.avg) AS avg_p_c;

STORE avg_per_country INTO 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/avg';

-- number of countries
n = FOREACH group_per_country GENERATE flatten($0) AS country, COUNT($1.avg) AS count;

-- generate square (x - avg)²
avg_per_country = FILTER avg_per_country BY avg_p_c > 0;
x = JOIN avg_per_country BY country, country By country;
x = FOREACH x GENERATE $0 AS country, $1 AS avg_p_c, $3 AS avg;
square_per_country = FOREACH x GENERATE country, (avg_p_c - avg)*(avg_p_c - avg) AS sq;

-- sum (x_i - avg)²
g_to_sum = GROUP square_per_country BY country;
sumatory = FOREACH g_to_sum GENERATE $0 AS country, SUM($1.sq) AS s;

-- filter
-- n = FOREACH group_per_country GENERATE flatten($0) AS country, COUNT($1.avg) AS count;
number_of_countries = FILTER n BY count > 1;
sumatory = FILTER sumatory BY $1 is not null;

STORE n into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/n_countries';
STORE sumatory into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/sum_temp';

n = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/n_countries/part-r-00000' USING PigStorage('\t')
AS (country, count);
sumatory = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/sum_temp/part-r-00000' USING PigStorage('\t')
AS (country, sum);

-- division
n_sumatory = JOIN sumatory BY country, n BY country; --- Error DESCONOCIDO;
division = FOREACH n_sumatory GENERATE $0 AS country, (float)($1/$3) AS div;

-- GET STDDEV
std = FOREACH division GENERATE country, SQRT(div);

STORE std into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/std';



