select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select _airbyte_data
from lakehouse.bronze.weatheronepoint
where _airbyte_data is null



      
    ) dbt_internal_test