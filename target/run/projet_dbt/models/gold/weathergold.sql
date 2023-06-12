
  
    

    create table clickhouse.gold.weathergold__dbt_tmp
      
    as (
      /*
    Welcome to your gold dbt model!
    Temperature, humidity, and wind speed.
*/



with silver_data as (

    SELECT
      coord_lon,
      coord_lat,
      CAST(main_temp AS DOUBLE) AS main_temp,
      CAST(main_humidity AS DOUBLE) AS main_humidity,
      CAST(wind_speed AS DOUBLE) AS wind_speed,
      dt
    FROM  lakehouse.silver.weathersil

)

select 
    coord_lon,
    coord_lat,
    dt,
    AVG(main_temp) AS avg_temp,
    AVG(main_humidity) AS avg_humidity,
    AVG(wind_speed) AS avg_wind_speed
from silver_data
group by coord_lon, coord_lat
    );

  