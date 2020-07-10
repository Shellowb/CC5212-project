-- CSV FORMAT
--      LAND MEASURES                                                                                  |    LAND AND OCEAN MEASURES
-- dt,  AvgTemperature, AvgTUncertanty, MaxTemperature, MaxTUncertainty, MinTemperature,MinTUncertainty, LOAvgTemperature, LOAvgTUncertainty
-- date, avg, avgu, max, maxu, min, minu, loavg, loavgu

-- Load the Maind Data
temperatures = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalTemperatures.csv' USING PigStorage(',') AS (date, avg, avgu, max, maxu, min, minu, loavg, loavgu);

-- MAX AVG Over History (Get an automated peak)
group_all = GROUP temperatures ALL;
Tops = FOREACH group_all  GENERATE
          (student_details.firstname, student_details.gpa), MAX(student_details.gpa);

-- MIN AVG Over History (Get an automated deep)
asc_oredered = ORDER temperatures BY avg ASC;
-- STDEV Over History

-- AVG Over Hisotry
averages = FOREACH temperatures GENERATE average as date, AVERAGE($1);
STORE averages INTO '/uhadoop2020/uhadoop2020/grupo08/project/results';