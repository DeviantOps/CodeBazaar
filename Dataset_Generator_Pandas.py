import numpy as np
import pandas as pd

# Fixer la seed pour une reproductibilité
np.random.seed(42)

# Générer un tableau de données avec des valeurs aléatoires basées sur des fonctions mathématiques
data = {
    'Colonne1': np.random.uniform(0, 10, 8000),
    'Colonne2': np.random.normal(5, 2, 8000),
    'Colonne3': np.random.randint(1, 100, 8000),
    'Colonne4': np.sin(np.random.uniform(0, 2*np.pi, 8000)),
    'Colonne5': np.cos(np.random.uniform(0, 2*np.pi, 8000)),
    'Colonne6': np.exp(np.random.uniform(0, 5, 8000))
}

# Créer un DataFrame pandas
df = pd.DataFrame(data)

# Enregistrer le DataFrame dans un fichier CSV
df.to_csv('dataset_test.csv', index=False)
