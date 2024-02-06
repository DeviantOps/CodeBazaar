import json

# Ouvrir le fichier JSON
with open('chemin/vers/le/fichier.json') as f:
    data = json.load(f)

# Afficher les données complètes
print(data)

# Accéder à une clé spécifique
print(data['clé'])

# Parcourir une liste de dictionnaires
for item in data['liste']:
    print(item['clé1'], item['clé2'])

# Modifier une valeur
data['clé'] = 'nouvelle valeur'

# Écrire les modifications dans le fichier JSON
with open('chemin/vers/le/fichier.json', 'w') as f:
    json.dump(data, f)
