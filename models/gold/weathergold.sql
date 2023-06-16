/*
    Welcome to your gold dbt model!
    Temperature, humidity, and wind speed.
*/

{{ config(materialized='table') }}

with silver_data as (

    SELECT
      DATE(dt) AS date,
      HOUR(dt) AS hour,
      MINUTE(dt) AS minute,
      CAST(main_temp AS DOUBLE) AS main_temp,
      CAST(main_humidity AS DOUBLE) AS main_humidity,
      CAST(wind_speed AS DOUBLE) AS wind_speed
    FROM  {{ source('sourcesilver', 'weathersil') }}

)

select 
    date,
    hour,
    minute,
    AVG(main_temp) AS avg_temp,
    MIN(main_temp) AS min_temp,
    MAX(main_temp) AS max_temp,
    AVG(main_humidity) AS avg_humidity,
    MIN(main_humidity) AS min_humidity,
    MAX(main_humidity) AS max_humidity,
    AVG(wind_speed) AS avg_wind_speed,
    MIN(wind_speed) AS min_wind_speed,
    MAX(wind_speed) AS max_wind_speed
from silver_data
group by date, hour,minute
