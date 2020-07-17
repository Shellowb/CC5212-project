#  Temperature Exploration
_José Díaz, Tomás Letelier, Marcelo Becerra_

June 24, 2020


## Goal
The current project pursuit is to get useful conclusions about the temperature analysis on earth through the time (months) and places (positions, longitude and latitude) over the globe. This project studies the tendencies of temperatures, per zone and detecting events and places that became or could become risky in a near future.


## Data
We use [Climate Change: Earth Surface Temperature Data](https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data) dataset.
It's a monthly temperature series from 1750 to 2013.
It's part of a scientific initiative pursuing to answer observations made by climate change sceptics.

## Methods
We define four categories to analyse the data:
- **Trends (T):** we work with the average to generate an analysis over the time, and look for the tendencies in the temperature.
- **Zoning (Z)**: Separate and order the data into zones, to look up in specific regions over the globe.
- **Detect Events (DE)**: We want to detect particular events on the data such as heat waves, or cold waves.
- **Detect inhospitable places (DiP)**: We know, that certain temperatures make imposible to sustain human life naturally, for example Siberia in winter reachs temperatures of -20°C. This can _«immobilize an entire region. Even areas that normally experience mild winters can be hit with a major snowstorm or extreme cold. Winter storms can result in flooding, storm surge, closed highways, blocked roads, downed power lines and hypothermia.»_ [IFRC](https://www.ifrc.org/en/what-we-do/disaster-management/about-disasters/definition-of-hazard/extreme-temperatures/)

In base of these categories we answer the following questions about the data.

### Guiding questions
1. ¿Which are the most affected countries by the "changes" in temperature? **Z, T**
2. ¿Increase or decrease _delta_ of temperatures over the years? (Δ = Max - min) **T**
3. ¿What are the trend of _average_ temperature over the years? **T**
4. ¿Which is the tendency of the average temperature per zone? **Z, T**
5. ¿Which is the tendency from the extreme marks zones (-20, 20 °C) **Z, T** <br> 

_If we define a threshold, like 40 °C (an extreme heat temperature)_

6. ¿How many times this threshold is exceed? **T, DE**
7. ¿Can we identify heat and cold waves? **DE**
8. ¿Which places are becoming (tendencies) inhospitable? **DiP, T**

_To find more info go to the appendix_

### Framework
We decided to use PigLatin because it's simple, easy to program and its similar to SQL.


## Results
While we managed to create pig Queries to obtain interesting datasets from the original data (using a smaller sample to test code's functionality), unfortunately due to the size of the original dataset and the demand of the server the pig process crashed so we couldn't obtain any results.

## Conclusions
While we weren't able to get the final results we hoped for, we were able to create the codes necessary to obtain them, having successfully learned to use Pig and Hadoop in a way that can be applied to real world problems.
Some fixes to the problems we encountered could be to segment the original dataset into smaller batches or try to implement the Queries in another platform. 

## Apendix
### Waves
We define a wave as an extended period of time where the temperature is outside the normal cotas.
> A heat wave is a period of unusually hot weather that typically lasts two or more days. To be considered a heat wave, the temperatures have to be outside the historical averages for a given area.
> >Bibliography 1

Why study heat and cold waves?:
> Heat waves like this may be less exciting or dramatic than other natural disasters like tornados, hurricanes, flooding, or even thunderstorms, but heat waves kill more people in the United States than all other weather-related disasters combined
> > Bibliography 1

more info [Heat Waves](https://en.wikipedia.org/wiki/Heat_wave),
[Cold Waves](https://en.wikipedia.org/wiki/Cold_wave). <br>
**Related Dangers:** <br>
[Hypothermia](https://en.wikipedia.org/wiki/Hyperthermia) In humans, is defined as a body core temperature below 35.0 °C (95.0 °F) in humans.<br>
[Hyperthermia](https://en.wikipedia.org/wiki/Hypothermia)  In humans, is defined as a body core temperature greater than 37.5–38.3 °C (99.5–100.9 °F) <br>
This two, are conditions where an individual's body temperature is beyond normal or below normal, due to failed thermoregulation. In the case of hyperthermia the person's body produces or absorbs more heat than it dissipates and in the case of hypothermia losses more heat than it produces.
Both conditions can produce death.

We defined two standard ranges arbitrary to this study:
- Heat wave > 40 °C.
- Cold wave < 15 °C

Even when these are normal temperatures around the globe, this values are set not only to represent changes in trends of temperatures, also to identify hostile environments to human life. These two represent a danger zone in every humidity percentage. 

![Hyperthermia and Hipothermia](https://cdn.mos.cms.futurecdn.net/ozBdgXNz2Nyn2hLz4cVyyc-650-80.jpg)

### Events List
#### Heat waves
|when| where | T° | killed | source |
|---|:---:|:---:|---:|----|
|1896 August|Eastern North America | unknown | 1500| [wikipedia](https://en.wikipedia.org/wiki/List_of_heat_waves)
|2002 July| China | unknown | 7 | [CNN](http://edition.cnn.com/2002/WORLD/asiapcf/east/07/17/china.heatwave/index.html)
|2001 August| New Jersey| 41 °C | unknown| [wikipedia](https://en.wikipedia.org/wiki/List_of_heat_waves)
|2003| Europe|  47 °C - 117 °F| 15.000| [BBC](http://news.bbc.co.uk/2/hi/europe/3139694.stm)


#### Cold waves


## Bibliography
1. https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data
2. https://www.voanews.com/silicon-valley-technology/scientists-identify-way-predict-heat-waves
3. https://scijinks.gov/heat/
4. https://journals.ametsoc.org/jcli/article/31/1/61/94701/Detection-of-Intraseasonal-Large-Scale-Heat-Waves
