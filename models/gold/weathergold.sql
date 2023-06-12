/*
    Welcome to your gold dbt model!
    Temperature, humidity, and wind speed.
*/

{{ config(materialized='table') }}

with silver_data as (

    SELECT
      coord_lon,
      coord_lat,
      CAST(main_temp AS DOUBLE) AS main_temp,
      CAST(main_humidity AS DOUBLE) AS main_humidity,
      CAST(wind_speed AS DOUBLE) AS wind_speed,
    FROM  {{ source('sourcesilever', 'weathersil') }}

)

select 
    coord_lon,
    coord_lat,
    AVG(main_temp) AS avg_temp,
    AVG(main_humidity) AS avg_humidity,
    AVG(wind_speed) AS avg_wind_speed
from silver_data
group by coord_lon, coord_lat
