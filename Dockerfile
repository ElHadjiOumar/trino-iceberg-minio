# Utiliser l'image dbt-core comme base
FROM ghcr.io/dbt-labs/dbt-core:latest

# Installer le plugin dbt-trino
RUN pip install dbt-trino
