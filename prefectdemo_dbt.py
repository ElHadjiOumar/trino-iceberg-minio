from prefect import flow
from prefect.deployments import Deployment
from prefect.deployments import run_deployment
from prefect.server.schemas.schedules import CronSchedule
from prefect_dbt.cli import DbtCoreOperation


@flow(name="flow_dbt",retries=3,retry_delay_seconds=60)
def dbt_flow() -> str:
    result = DbtCoreOperation(
        commands=["dbt run --models weatheronepoint weathersil --target dev","dbt run --models weathergold --target gold"],
        project_dir=r".",
        profiles_dir=r".",
    )
    return result.run()


deploiement_dbt = Deployment.build_from_flow(
    flow= dbt_flow,
    name= "cron_dbt",
    schedule=(CronSchedule(cron="* * * * *", timezone="Europe/Paris"))
)

def main():
    run_deployment(name="flow_dbt/cron_dbt")

deploiement_dbt.apply()

if __name__ == "__main__":
    main()