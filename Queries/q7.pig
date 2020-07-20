/*
¿Can we identify heat and cold waves? DE
* */

country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCountry.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);

-- STDDEV for country
std_by_country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/std/part-r-00000' USING PigStorage('\t')
AS (country , stddev);

-- AVG for country
avg_by_country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/avg/part-r-00000' USING PigStorage('\t')
AS (country , avg_p_c);

-- For each country generate average
merge = JOIN country BY country, std_by_country BY country;
STORE merge into  'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/merge';
merge = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/merge/part-r-00000' USING PigStorage('\t')
              AS (date, avg, avgu, country, c2, stddev);

merge_2 = JOIN merge BY country, avg_by_country BY country;

SPLIT merge_2 INTO high_peaks IF avg > (avg_p_c+stddev), low_peaks IF avg < (avg_p_c-stddev);

STORE high_peaks into  'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/hp';
STORE low_peaks into  'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/lp';
high_peaks_2 = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/hp/part-r-00000' USING PigStorage('\t')
               AS (date, avg, avgu, country, c2, stddev, c3, avg_p_c);
low_peaks_2 = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/lp/part-r-00000' USING PigStorage('\t')
              AS (date, avg, avgu, country, c2, stddev, c3, avg_p_c);

high_peaks_3 = FOREACH high_peaks_2 GENERATE date AS date,
               country AS country, avg AS temperatature,
               avg_p_c AS normal, stddev AS delta;

low_peaks_3 = FOREACH low_peaks_2 GENERATE date AS date,
              country AS country, avg AS temperatature,
              avg_p_c AS normal, stddev AS delta;


heat_waves = LIMIT high_peaks_3 100;
cold_waves = LIMIT low_peaks_3 100;

STORE heat_waves into  'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/q7/hw';
STORE cold_waves into  'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/results/q7/cw';