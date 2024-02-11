import pandas as pd
import numpy as np
import json

# Chargement des spécifications de données depuis un fichier JSON
with open("specifications.json", "r") as f:
    specs = json.load(f)

# Création d'un DataFrame vide avec les colonnes spécifiées
df = pd.DataFrame(columns=specs["columns"])

# Ajout des données générées aléatoirement ou par une fonction spécifique pour chaque colonne
for col in df.columns:
    col_specs = specs["columns"][col]
    data_type = col_specs["type"]
    data_length = specs["rows"]
    if data_type == "int":
        df[col] = np.random.randint(col_specs["min"], col_specs["max"], size=data_length)
    elif data_type == "float":
        df[col] = np.random.uniform(col_specs["min"], col_specs["max"], size=data_length)
    elif data_type == "polynomial":
        x = np.linspace(0, 1, data_length)
        coeffs = np.random.uniform(col_specs["min"], col_specs["max"], size=col_specs["degree"] + 1)
        y = np.polyval(coeffs, x)
        df[col] = y
    elif data_type == "string":
        df[col] = [''.join(np.random.choice(list(col_specs["alphabet"]), size=col_specs["length"])) for _ in range(data_length)]

# Écriture des données dans un fichier CSV
df.to_csv("data.csv", index=False)
Les spécifications de données sont définies dans un fichier JSON, comme celui-ci :

json
Copy code
{
    "columns": {
        "col1": {
            "type": "int",
            "min": 0,
            "max": 100
        },
        "col2": {
            "type": "float",
            "min": 0.0,
            "max": 1.0
        },
        "col3": {
            "type": "polynomial",
            "min": -5,
            "max": 5,
            "degree": 2
        },
        "col4": {
            "type": "string",
            "length": 10,
            "alphabet": "abcdefghijklmnopqrstuvwxyz"
        }
    },
    "rows": 1000
}
