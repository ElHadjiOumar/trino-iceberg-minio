
    
    



select _airbyte_emitted_at
from lakehouse.bronze.weatheronepoint
where _airbyte_emitted_at is null


