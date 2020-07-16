
-- Load the Country data
country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCountry.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);

-- GET THE STANDARD DEV OVER THE YEARS.

-- Group by country
group_per_country = GROUP country BY country;
-- For each country generate average
avg_per_country = FOREACH group_per_country GENERATE flatten($0) AS country, AVG($1.avg) AS avg_p_c;
-- generate square (x - avg)²
x = JOIN avg_per_country BY country, country By country;
x = FOREACH x GENERATE $0 AS country, $1 AS avg_p_c, $3 AS avg;
square_per_country = FOREACH x GENERATE country, (avg_p_c - avg)*(avg_p_c - avg) AS sq;
-- number of countries
n = FOREACH group_per_country GENERATE flatten($0) AS country, COUNT($1.avg) AS count;
-- sum (x_i - avg)²
g_to_sum = GROUP square_per_country BY country;
sumatory = FOREACH g_to_sum GENERATE $0 AS country, SUM($1.sq) AS s;
-- filter
n = FILTER n BY count > 0;
sumatory = FILTER sumatory BY $1 is not null;
-- division
n_sumatory = JOIN sumatory BY $0, n BY $0; --- Error DESCONOCIDO;
division = FOREACH n_sumatory GENERATE $0 AS country, (float)($1/$3) AS div;
