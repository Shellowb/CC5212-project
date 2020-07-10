/*
    The main goal of this script is to identify Waves
    A wave of extreme heat or cold is defined in the README.md
    document.
    We provide a general algorithm to detect a wave and a example cases
    We also try to identify specific historic Events
*/

-- Heat cota 40 °C
-- Cold cota -15 °C

/*      LOAD HELP

cities = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCity.csv' USING PigStorage(',')
AS (date , avg , agvu ,city , country,  la , lo);

country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCountry.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);

majorCity = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByMajorCity.csv' USING PigStorage(',')
AS  (date, avg, avgu, city , country , la ,lo);

state = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByState.csv' USING PigStorage(',')
AS  (date, avg, avgu, state , country);

global = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalTemperatures.csv' USING PigStorage(',')
AS (date, avg, avgu, max, maxu, min, minu, loavg, loavgu);

 */


global = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalTemperatures.csv' USING PigStorage(',')
AS (date, avg, avgu, max, maxu, min, minu, loavg, loavgu);