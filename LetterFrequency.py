import collections

text = "voici un exemple de texte a analyser"

# Compter le nombre d'occurrences de chaque lettre
letter_counts = collections.Counter(text)

# Calculer la fréquence de chaque lettre
total_letters = sum(letter_counts.values())
for letter, count in letter_counts.items():
    frequency = count / total_letters
    print(f"{letter}: {frequency:.2f}")
