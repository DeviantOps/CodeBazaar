import math

text = "voici un exemple de texte a analyser"

# Compter le nombre d'occurrences de chaque lettre
letter_counts = collections.Counter(text)

# Calculer la probabilité de chaque lettre
total_letters = sum(letter_counts.values())
letter_probs = [count / total_letters for count in letter_counts.values()]

# Calculer l'entropie
entropy = -sum(p * math.log2(p) for p in letter_probs)
print(f"Entropie: {entropy:.2f}")
