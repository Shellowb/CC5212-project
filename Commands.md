# Commands
## Start and Initialise Framework
### Session
```shell script
ssh uhadoop@cm.dcc.uchile.cl -p 220
HADcc5212$oop
```

### Nautilus connection
```shell script
sftp://uhadoop@cm.dcc.uchile.cl:/uhadoop2020/
```

### Copy 
do
```shell script
scp -P 220 Data/temperatures/GlobalLandTemperaturesByCity.csv uhadoop@cm.dcc.uchile.cl:/data/2020/uhadoop/grupo08/project
HADcc5212$oop
```
And the same 
```shell script
GlobalLandTemperaturesByCountry.csv
GlobalLandTemperaturesByMajorCity.csv
GlobalLandTemperaturesByState.csv
GlobalTemperatures.csv
```

### Load into the file System
```shell script
cd grupo08/project
hdfs dfs -put GlobalTemperatures.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put GlobalLandTemperaturesByCountry.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put GlobalLandTemperaturesByState.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put GlobalLandTemperaturesByMajorCity.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put GlobalTemperatures.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put GlobalLandTemperaturesByCity.csv uhadoop2020/grupo08/project/temperature


hdfs dfs -put city_reduced.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put country_reduced.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put global_reduced.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put majorCity_reduced.csv uhadoop2020/grupo08/project/temperature
hdfs dfs -put state_reduced.csv uhadoop2020/grupo08/project/temperature
```

### Get results
```shell script
hdfs dfs -get /user/uhadoop/uhadoop2020/grupo08/project/results/avg results/
```

### Look into directory
```shell script
hdfs dfs -ls uhadoop2020/grupo08
hdfs dfs -ls uhadoop2020/grupo08/project
hdfs dfs -ls uhadoop2020/grupo08/project/temperature
```


## PIG
### run local
`pig -x local`

### screen
```shell script
screen -r 4286.pts-10.cluster-01
ctrl + a + d
```