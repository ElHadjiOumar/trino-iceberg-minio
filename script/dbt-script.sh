#!/bin/bash

# Set up environment here, if necessary...



# Then either run a dbt command:
dbt run --models weatheronepoint weathersil --target dev

dbt run --models weathergold --target gold

# pip install -U prefect

# prefect server start


# Or keep the container alive:
tail -f /dev/null
