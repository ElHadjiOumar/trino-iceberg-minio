
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below 
*/

{{ config(materialized='table') }}

with source_data as (

    SELECT
--   json_extract_scalar(_airbyte_data, '$.coord.lon') AS coord_lon,
--   json_extract_scalar(_airbyte_data, '$.coord.lat') AS coord_lat,
--   json_extract_scalar(_airbyte_data, '$.weather[0].main') AS weather_main,
--   json_extract_scalar(_airbyte_data, '$.weather[0].description') AS weather_description,
--   json_extract_scalar(_airbyte_data, '$.main.temp') AS main_temp,
--   json_extract_scalar(_airbyte_data, '$.main.humidity') AS main_humidity,
--   json_extract_scalar(_airbyte_data, '$.wind.speed') AS wind_speed,
--   json_extract_scalar(_airbyte_data, '$.wind.deg') AS wind_deg
  *
  FROM  {{ source('source', 'weather') }}
  WHERE
  json_extract_scalar(_airbyte_data, '$.coord.lon') IS NOT NULL
  AND json_extract_scalar(_airbyte_data, '$.coord.lat') IS NOT NULL

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
