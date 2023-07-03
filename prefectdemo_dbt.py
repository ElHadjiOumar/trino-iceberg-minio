# Importation de flow
from prefect import flow

# Importation des dependances de airbyte 
from prefect_airbyte.server import AirbyteServer
from prefect_airbyte.connections import AirbyteConnection
from prefect_airbyte.flows import run_connection_sync

# Importation des dependances de DBT 
from prefect_dbt.cli.commands import DbtCoreOperation

# Import les dependances pour deployer et schedules notre code
from prefect.deployments import run_deployment
from prefect.deployments import Deployment
from prefect.server.schemas.schedules import CronSchedule


server = AirbyteServer(server_host="airbyte-proxy", server_port=8000)

connection = AirbyteConnection(
    airbyte_server=server,
    connection_id="0b39e9b8-d0da-4683-94c0-190ffdb88816",
    status_updates=True,
)
@flow(name="flow_airbyte")
def airbyte_syncs():
    sync_result = run_connection_sync(
        airbyte_connection=connection,
    )
    print(f'UNE ACTUALISATION AIRBYTE : {sync_result.records_synced}')


@flow(name="flow_dbt",retry_delay_seconds=5,retries=3)
def dbt_flow() -> str:
    result = DbtCoreOperation(
        commands=["dbt run --models weatheronepoint weathersil --target dev","dbt run --models weathergold --target gold"],
        project_dir=r".",
        profiles_dir=r".",
    )
    return result.run()


deploiement_airbyte = Deployment.build_from_flow(
    flow= airbyte_syncs,
    name= "cron_airflow",
    schedule=(CronSchedule(cron="* * * * *", timezone="Europe/Paris"))
)

deploiement_dbt = Deployment.build_from_flow(
    flow= dbt_flow,
    name= "cron_dbt",
    schedule=(CronSchedule(cron="* * * * *", timezone="Europe/Paris"))
)

def main_airflow():
    run_deployment(name="flow_airbyte/cron_airflow")

def main_dbt():
    run_deployment(name="flow_dbt/cron_dbt")

deploiement_airbyte.apply()
deploiement_dbt.apply()

if __name__ == "__main__":
    main_airflow()
    main_dbt()

