select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select weather_description
from hive.weatheronepoint.my_first_dbt_model
where weather_description is null



      
    ) dbt_internal_test