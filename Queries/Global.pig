-- CSV FORMAT
--      LAND MEASURES                                                                                  |    LAND AND OCEAN MEASURES
-- dt,  AvgTemperature, AvgTUncertanty, MaxTemperature, MaxTUncertainty, MinTemperature,MinTUncertainty, LOAvgTemperature, LOAvgTUncertainty
-- date, avg, avgu, max, maxu, min, minu, loavg, loavgu

-- Load the Maind Data
temperatures = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalTemperatures.csv' USING PigStorage(',') AS (date, avg, avgu, max, maxu, min, minu, loavg, loavgu);
temperatures = FILTER temperatures BY GetYear(date) > 1800;

-- General observation over Min Max -> there are some years that doesn't have all the data, and a null < anything in the comprarison.

-- MAX AVG Over History (Get an automated peak)
desc_order = ORDER temperatures BY max DESC;
top1 = LIMIT desc_order 2;
DUMP top1;

-- MIN AVG Over History (Get an automated deep)
asc_order = ORDER temperatures BY min ASC;
top2 = LIMIT asc_order 2;
DUMP top2;


-- STDEV Over History
--group_all = GROUP temperatures ALL;



-- AVG Over Hisotry
averages = FOREACH temperatures GENERATE average as date, AVERAGE($1);
STORE averages INTO '/uhadoop2020/uhadoop2020/grupo08/project/results';