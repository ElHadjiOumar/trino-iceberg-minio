
  
    

    create table lakehouse.silver.weathersil__dbt_tmp
      
    as (
      /*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below 
*/



with bronze_data  as (

    SELECT
  json_extract_scalar(_airbyte_data, '$.coord.lon') AS coord_lon,
  json_extract_scalar(_airbyte_data, '$.coord.lat') AS coord_lat,
  json_extract_scalar(_airbyte_data, '$.weather[0].main') AS weather_main,
  json_extract_scalar(_airbyte_data, '$.weather[0].description') AS weather_description,
  CAST(json_extract_scalar(_airbyte_data, '$.main.temp') AS DOUBLE) - 273.15 AS main_temp,
  json_extract_scalar(_airbyte_data, '$.main.humidity') AS main_humidity,
  json_extract_scalar(_airbyte_data, '$.main.pressure') AS main_pressure,
--   json_extract_scalar(_airbyte_data, '$.main.sea_level') AS sea_level,
--   json_extract_scalar(_airbyte_data, '$.main.grnd_level') AS grnd_level,
  json_extract_scalar(_airbyte_data, '$.wind.speed') AS wind_speed,
--   json_extract_scalar(_airbyte_data, '$.wind.deg') AS wind_deg,
--   json_extract_scalar(_airbyte_data, '$.wind.gust') AS wind_gust,
--   json_extract_scalar(_airbyte_data, '$.rain.1h') AS rain_1h,
  json_extract_scalar(_airbyte_data, '$.clouds.all') AS clouds,
  json_extract_scalar(_airbyte_data, '$.visibility') AS visibility,
 cast(from_unixtime(CAST(json_extract_scalar(_airbyte_data, '$.dt') AS DOUBLE)) at time zone 'Europe/Paris' as timestamp(6) with time zone) AS dt,
 cast(from_unixtime(CAST(json_extract_scalar(_airbyte_data, '$.sys.sunrise') AS DOUBLE)) at time zone 'Europe/Paris' as timestamp(6) with time zone) AS sunrise,
 cast(from_unixtime(CAST(json_extract_scalar(_airbyte_data, '$.sys.sunset') AS DOUBLE)) at time zone 'Europe/Paris' as timestamp(6) with time zone) AS sunset,
  json_extract_scalar(_airbyte_data, '$.sys.type') AS sys_type,
  json_extract_scalar(_airbyte_data, '$.sys.id') AS sys_id,
  json_extract_scalar(_airbyte_data, '$.sys.country') AS sys_country,
  json_extract_scalar(_airbyte_data, '$.timezone') AS timezone,
  json_extract_scalar(_airbyte_data, '$.id') AS city_id,
  json_extract_scalar(_airbyte_data, '$.name') AS city_name,
  json_extract_scalar(_airbyte_data, '$.cod') AS response_code
   FROM  lakehouse.bronze.weatheronepoint
  WHERE
  json_extract_scalar(_airbyte_data, '$.coord.lon') IS NOT NULL
  AND json_extract_scalar(_airbyte_data, '$.coord.lat') IS NOT NULL

)

select *
from bronze_data 

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
    );

  