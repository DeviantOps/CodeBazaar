az pipelines create --name MonPipeline --repository MonDepot --branch main --yml-path chemin/vers/fichier.yaml
#Remplace MonPipeline par le nom souhaité pour ton pipeline, 
#MonDepot par le nom de ton dépôt Git et chemin/vers/fichier.yaml par le chemin réel vers ton fichier YAML.
#
#Vérifie et exécute le pipeline : Une fois que le pipeline est importé avec succès, tu peux vérifier sa configuration à l'aide de la commande az pipelines show 
#et exécuter le pipeline avec la commande az pipelines run.
#
az pipelines show --name MonPipeline --org MonOrganisation --project MonProjet
az pipelines run --name MonPipeline --org MonOrganisation --project MonProjet
