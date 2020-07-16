cd Data

head -1 temperatures/GlobalLandTemperaturesByCity.csv > reduced/city_reduced.csv
head -1 temperatures/GlobalLandTemperaturesByCountry.csv > reduced/country_reduced.csv
head -1 temperatures/GlobalLandTemperaturesByMajorCity.csv > reduced/majorCity_reduced.csv
head -1 temperatures/GlobalLandTemperaturesByState.csv > reduced/state_reduced.csv
head -1 temperatures/GlobalTemperatures.csv > reduced/global_reduced.csv

tail -1000 temperatures/GlobalLandTemperaturesByCity.csv >> reduced/city_reduced.csv
tail -1000 temperatures/GlobalLandTemperaturesByCountry.csv >> reduced/country_reduced.csv
tail -1000 temperatures/GlobalLandTemperaturesByMajorCity.csv >> reduced/majorCity_reduced.csv
tail -1000 temperatures/GlobalLandTemperaturesByState.csv >> reduced/state_reduced.csv
tail -1000 temperatures/GlobalTemperatures.csv >> reduced/global_reduced.csv



