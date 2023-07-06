/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below 
*/



with source_data as (

    SELECT
    *
    FROM  source.weather.weatherbordeaux
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