select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select main_temp
from hive.weatheronepoint.my_first_dbt_model
where main_temp is null



      
    ) dbt_internal_test