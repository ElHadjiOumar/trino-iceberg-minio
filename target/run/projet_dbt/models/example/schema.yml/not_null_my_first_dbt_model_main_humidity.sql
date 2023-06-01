select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select main_humidity
from hive.weatheronepoint.my_first_dbt_model
where main_humidity is null



      
    ) dbt_internal_test