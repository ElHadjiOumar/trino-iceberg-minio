select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select wind_speed
from hive.weatheronepoint.my_first_dbt_model
where wind_speed is null



      
    ) dbt_internal_test