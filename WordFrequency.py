import collections

text = "voici un exemple de texte a analyser"

# Séparer le texte en mots
words = text.split()

# Compter le nombre d'occurrences de chaque mot
word_counts = collections.Counter(words)

# Calculer la fréquence de chaque mot
total_words = sum(word_counts.values())
for word, count in word_counts.items():
    frequency = count / total_words
    print(f"{word}: {frequency:.2f}")
