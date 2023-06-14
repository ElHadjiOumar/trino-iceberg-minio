# from prefect import flow
# from prefect_dbt import DbtCoreOperation
# from prefect_dbt.cli import DbtCliProfile


# dbt_cli_profile = DbtCliProfile(
#     name="projet_dbt",
#     target="gold"
# )
# profile = dbt_cli_profile.get_profile()

# @flow
# def trigger_dbt_flow() -> str:
#     result = DbtCoreOperation(
#         commands=["dbt debug"],
#         project_dir='.',
#         profiles_dir=profile
#     ).run()
#     return result

# trigger_dbt_flow()




from prefect import flow
from prefect_airbyte.server import AirbyteServer
from prefect_airbyte.connections import AirbyteConnection
from prefect_airbyte.flows import run_connection_sync
from prefect_dbt.cli.commands import trigger_dbt_cli_command
from prefect_dbt.cli.commands import DbtCoreOperation
from prefect_dbt.cli.commands import trigger_dbt_cli_command

import os
os.environ["PREFECT__TASKS__SHELL"] = "/bin/bash"


# server = AirbyteServer(server_host="localhost", server_port=8000)

# connection = AirbyteConnection(
#     airbyte_server=server,
#     connection_id="0b39e9b8-d0da-4683-94c0-190ffdb88816",
#     status_updates=True,
#)
# @flow
# def airbyte_syncs():
#     # do some setup

#     sync_result = run_connection_sync(
#         airbyte_connection=connection,
#     )

#     # do some other things, like trigger DBT based on number of records synced
#     print(f'Number of Records Synced: {sync_result.records_synced}')


@flow
def dbt_flow() -> str:
    result = DbtCoreOperation(
        commands=["dbt run --models weatheronepoint weathersil --target dev"],
        project_dir=r".",
        profiles_dir=r".",
    )
    return result

# dbt_flow()
# Run the flow
if __name__ == "__main__":
    # airbyte_syncs()
    # dbt_flow()
    flow = dbt_flow()
    state = flow.run()
    print(state)