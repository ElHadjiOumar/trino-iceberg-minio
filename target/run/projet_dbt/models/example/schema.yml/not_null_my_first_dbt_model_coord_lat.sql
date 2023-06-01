select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select coord_lat
from hive.weatheronepoint.my_first_dbt_model
where coord_lat is null



      
    ) dbt_internal_test