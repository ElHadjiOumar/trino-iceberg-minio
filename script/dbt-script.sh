#!/bin/bash

# Set up environment here, if necessary...

sleep 90

# Then either run a dbt command:
dbt run --models weatheronepoint weathersil --target dev

dbt run --models weathergold --target gold


# Or keep the container alive:
tail -f /dev/null
