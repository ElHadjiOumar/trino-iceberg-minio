
  
    

    create table clickhouse.gold.weathergold__dbt_tmp
      
    as (
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
    from_unixtime(CAST(json_extract_scalar(_airbyte_data, '$.dt') AS DOUBLE)),
    main_temp,
    main_humidity,
    wind_speed
from silver_data
    );

  