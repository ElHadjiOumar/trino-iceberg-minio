#!/bin/bash

# Set up environment here, if necessary...

pip install "prefect-dbt[cli]"

prefect orion start

# Or keep the container alive:
tail -f /dev/null
