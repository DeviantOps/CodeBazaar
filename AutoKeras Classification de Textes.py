import autokeras as ak

# Chemin vers le répertoire contenant les fichiers ASCII
repo_path = "/chemin/vers/le/repo"

# Créer un Dataframe pandas à partir des fichiers ASCII
import pandas as pd
import os

data = []
for root, dirs, files in os.walk(repo_path):
    for file in files:
        if file.endswith(".txt"): # modifier selon l'extension des fichiers contenant les codes sources
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                text = f.read()
                data.append([text, os.path.basename(root)])
df = pd.DataFrame(data, columns=["text", "label"])

# Créer un objet TextClassifier et l'entraîner sur les données
clf = ak.TextClassifier(max_trials=10)
clf.fit(df["text"], df["label"])

# Évaluer le modèle
loss, accuracy = clf.evaluate(df["text"], df["label"])
print('Accuracy: %f' % (accuracy*100))
