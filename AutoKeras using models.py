import autokeras as ak
import pandas as pd

# Charger le modèle entraîné à partir du fichier auto_model.h5
clf = ak.TextClassifier()
clf.load_model("auto_model.h5")

# Exemple de texte inconnu
text = "def add(a, b):\n    return a + b"

# Faire une prédiction sur le texte inconnu
y_pred = clf.predict(pd.Series(text))

# Afficher la prédiction
print(y_pred)
