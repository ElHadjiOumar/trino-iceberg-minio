from prefect import flow
from prefect_dbt import DbtCoreOperation
from prefect_dbt.cli import DbtCliProfile


dbt_cli_profile = DbtCliProfile(
    name="projet_dbt",
    target="gold"
)
profile = dbt_cli_profile.get_profile()

@flow
def trigger_dbt_flow() -> str:
    result = DbtCoreOperation(
        commands=["dbt debug"],
        project_dir='.',
        profiles_dir=profile
    ).run()
    return result

trigger_dbt_flow()