### By City
|csv names |dt|Average Temperature|Average Temperature Uncertainty|City|Country|Latitude|Longitude
|---|---|---|---|---|---|---|---|
|pig used alias | date | avg | agvu |city | country|  la | lo |
|example|1743-11-01|6.068|1.7369999999999999|Århus|Denmark|57.05N|10.33E|
load as
```pig
cities = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCity.csv' USING PigStorage(',')
AS (date , avg , agvu ,city , country,  la , lo);
```

### Country
|csv names | dt|Average Temperature|Average Temperature Uncertainty|Country|
|---|---|---|---|---|
|pig used alias | date| avg| avgu| country|
|example |1743-11-01|4.3839999999999995|2.294|Åland|
load as
```pig
country = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByCountry.csv' USING PigStorage(',')
AS ( date, avg, avgu, country);
```
### Major City
|csv names | dt|Average Temperature|Average Temperature Uncertainty|City|Country | Latitude| Longitude |
|---|---|---|---|---|---|---|---|
|pig used alias| date| avg| avgu| city | country | la |lo|
|example |1849-01-01|26.704|1.435|Abidjan|Côte D'Ivoire|5.63N|3.23W |
             
load as
```pig
majorCity = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByMajorCity.csv' USING PigStorage(',')
AS  (date, avg, avgu, city , country , la ,lo);
```
### By State
|csv names | dt|Average Temperature|Average Temperature Uncertainty|State|Country|
|---|---|---|---|---|---|
|pig used alias| date| avg| avgu| state | country |
|example|1855-05-01|25.544|1.171|Acre|Brazil|
load as
```pig
state = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalLandTemperaturesByState.csv' USING PigStorage(',')
AS  (date, avg, avgu, state , country);
```
### Global
|csv names |dt| Land Average Temperature| Land Average Temperature Uncertainty| Land Max Temperature| Land  Max Temperature Uncertainty| Land Min Temperature| Land Min Temperature Uncertainty| Land and Ocean Average Temperature| Land and Ocean Average Temperature Uncertainty |
|---|---|---|---|---|---|---|---|---|---|
|pig used alias| date| avg| avgu| max| maxu| min| minu| loavg| loavgu|
|example|

load as
```pig
global = LOAD 'hdfs://cm:9000/user/uhadoop/uhadoop2020/grupo08/project/temperature/GlobalTemperatures.csv' USING PigStorage(',')
AS (date, avg, avgu, max, maxu, min, minu, loavg, loavgu);
```