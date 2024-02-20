import os
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer

# Télécharger les ressources nécessaires de NLTK
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

# Définir les répertoires contenant les fichiers textes d'apprentissage
train_dir = '/chemin/vers/le/repertoire/train'

# Initialiser la liste de documents et de labels
docs = []
labels = []

# Parcourir tous les fichiers dans le répertoire d'apprentissage
for category in os.listdir(train_dir):
    category_dir = os.path.join(train_dir, category)
    for file_name in os.listdir(category_dir):
        file_path = os.path.join(category_dir, file_name)
        with open(file_path, 'r') as f:
            content = f.read()
            # Supprimer les signes de ponctuation et les chiffres
            content = ''.join(e for e in content if e.isalpha() or e.isspace())
            # Tokeniser les mots
            tokens = word_tokenize(content.lower())
            # Supprimer les stopwords
            tokens = [word for word in tokens if word not in stopwords.words('english')]
            # Lematizer les mots
            lemmatizer = WordNetLemmatizer()
            tokens = [lemmatizer.lemmatize(word) for word in tokens]
            # Ajouter les tokens au document
            docs.append(' '.join(tokens))
            # Ajouter le label au document
            labels.append(category)

# Imprimer le nombre de documents et de labels
print(f'Nombre de documents : {len(docs)}')
print(f'Nombre de labels : {len(labels)}')
Dans cet exemple, nous avons utilisé la bibliothèque NLTK pour nettoyer les données en supprimant les signes de ponctuation et les chiffres, en tokenisant les mots, en supprimant les stopwords et en lemmatisant les mots. Nous avons ensuite ajouté les tokens et les labels au document. Cela peut être utilisé pour préparer une base de textes pour l'entraînement d'un modèle de classification de texte.

