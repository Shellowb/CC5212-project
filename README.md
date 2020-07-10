#  Temperature Exploration
_José Díaz, Tomás Letelier, Marcelo Becerra_

June 24, 2020


## Goal
The current project pursuit to get useful conclusions about the temperature analysis on earth through the time (months) and places (positions, longitude and latitude) over the globe. This project studies the tendencies of temperatures, per zone and detecting events and places that became or could become risky (mainly temporary).

## Data
We use [Climate Change: Earth Surface Temperature Data](https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data) dataset.
It's a monthly temperature series from 1750 to 2013.
It's part of a scientific initiative pursuing to answer observations made by climate change sceptics.

## Methods
We define four categories to analyse data:
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

### Framework
We decided to use pig, cause: --------

### Results

### Conclusions

## Apendix
![Hyperthermia and Hipothermia](https://cdn.mos.cms.futurecdn.net/ozBdgXNz2Nyn2hLz4cVyyc-650-80.jpg)