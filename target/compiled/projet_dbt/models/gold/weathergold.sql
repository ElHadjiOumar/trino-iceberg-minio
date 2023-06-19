/*
    Welcome to your gold dbt model!
    Temperature, humidity, and wind speed.
*/



with silver_data as (

    SELECT
      dt,
      main_temp,
      main_humidity,
      wind_speed
    FROM  lakehouse.silver.weathersil

)

select 
    dt,
    main_temp,
    main_humidity,
    wind_speed
from silver_data