select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select _airbyte_emitted_at
from lakehouse.bronze.toto
where _airbyte_emitted_at is null



      
    ) dbt_internal_test