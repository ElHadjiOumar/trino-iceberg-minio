#!/bin/bash

# Set up environment here, if necessary...



# Then either run a dbt command:
# dbt run --models weatheronepoint weathersil --target dev

# dbt run --models weathergold --target gold

pip install -U prefect  

pip install prefect-dbt

pip install prefect-airbyte


sleep 30

while true; do
  # Lancement du serveur Prefect en arrière-plan
  prefect server start & PID_SERVER=$!
  sleep 20  # Donnez un peu de temps au serveur pour démarrer

  # Lancement de l'agent Prefect en arrière-plan
  prefect agent start -q 'default' & PID_AGENT=$!
  sleep 20  # Donnez un peu de temps à l'agent pour démarrer

  # Lancement du script Python en arrière-plan
  python prefectdemo_dbt.py & PID_PYTHON=$!

  # Attente de la fin de tous les processus
  wait $PID_SERVER
  wait $PID_AGENT
  wait $PID_PYTHON

  # Vérification du statut des processus
  if [ $? -ne 0 ]; then
    echo "L'un des processus s'est arrêté. Relance des commandes..."
  else
    echo "Tous les processus se sont terminés avec succès."
    break  # Sortie de la boucle while
  fi
done

# Or keep the container alive:
tail -f /dev/null
