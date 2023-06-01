select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select wind_deg
from hive.weatheronepoint.my_first_dbt_model
where wind_deg is null



      
    ) dbt_internal_test