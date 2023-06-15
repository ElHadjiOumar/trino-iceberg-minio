#!/bin/bash

# Set up environment here, if necessary...



# Then either run a dbt command:
# dbt run --models weatheronepoint weathersil --target dev

# dbt run --models weathergold --target gold

pip install -U prefect  

pip install prefect-dbt


# Then run the commands
prefect server start &  PID_SERVER=$!
sleep 10  # give some time for the server to start up

prefect agent start -q 'default' &  PID_AGENT=$!
sleep 10  # give some time for the agent to start up

python prefectdemo_dbt.py & PID_PYTHON=$!

# wait for all tasks to complete
wait $PID_SERVER
wait $PID_AGENT
wait $PID_PYTHON


# prefect server start


# Or keep the container alive:
tail -f /dev/null
