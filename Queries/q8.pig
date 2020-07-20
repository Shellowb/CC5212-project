/**
* ¿Which places are becoming (tendencies) inhospitable? DiP, T
*
* treshold
* heat 35
* cold -8
*/

/*test
cities = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/city_reduced.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);
*/
cities = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCity.csv' USING PigStorage(',')
AS (date , avg , agvu ,city , country,  la , lo);

heat_highs = FILTER cities BY avg > 30;
cold_deeps = FILTER cities BY avg < -4;

h_by_countries = GROUP heat_highs BY country;
c_by_countries = GROUP cold_deeps BY country;

count_heat = FOREACH h_by_countries GENERATE flatten($0) AS country, COUNT($1.avg) AS cnt;
count_cold = FOREACH c_by_countries GENERATE flatten($0) AS country, COUNT($1.avg) AS cnt;

ordered_count_heat = ORDER count_heat BY cnt DESC;
ordered_count_cold = ORDER count_cold BY cnt ASC;

top_heat = LIMIT ordered_count_heat 10;
top_cold = LIMIT ordered_count_cold 10;

STORE top_heat into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/q8/th';
STORE top_cold into 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/q8/tc';