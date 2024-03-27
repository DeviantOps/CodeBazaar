import os
import csv
from math import sqrt
from colorama import Fore, Back, Style, init

# Fonctions utilitaires

def dot_product(v1, v2):
    return sum(x * y for x, y in zip(v1, v2))

def magnitude(v):
    return sqrt(sum(x**2 for x in v))

# Fonctions de similarité

def hamming_similarity(str1, str2):
    if len(str1) != len(str2):
        #raise ValueError("Les chaînes doivent avoir la même longueur")
        return 0.0
    else:
        return sum(c1 != c2 for c1, c2 in zip(str1, str2))


def cosine_similarity(content1, content2):
    vector1 = [content1.split().count(word) for word in set(content1.split())]
    vector2 = [content2.split().count(word) for word in set(content2.split())]

    dot_product_value = dot_product(vector1, vector2)
    magnitude1 = magnitude(vector1)
    magnitude2 = magnitude(vector2)

    if magnitude1 == 0 or magnitude2 == 0:
        return 0.0
    else:
        return dot_product_value / (magnitude1 * magnitude2)

def jaccard_similarity(content1, content2):
    set1 = set(content1.split())
    set2 = set(content2.split())
    intersection = len(set1.intersection(set2))
    union = len(set1.union(set2))
    if union == 0:
        similarity = 0.0
    else:
        similarity = intersection / union
        
    return similarity

def levenshtein_distance(content1, content2):
    m, n = len(content1), len(content2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]

    for i in range(m + 1):
        for j in range(n + 1):
            if i == 0:
                dp[i][j] = j
            elif j == 0:
                dp[i][j] = i
            elif content1[i - 1] == content2[j - 1]:
                dp[i][j] = dp[i - 1][j - 1]
            else:
                dp[i][j] = 1 + min(dp[i - 1][j], # Suppression
                                  dp[i][j - 1], # Insertion
                                  dp[i - 1][j - 1]) # Remplacement
    if max(m,n)==0 :
        return 0.0
    else:
        return 1 - (dp[m][n] / max(m, n))

def jaro_winkler_similarity(content1, content2, prefix_scale=0.1):
    # Jaro similarity
    def jaro_similarity(s1, s2):
        if not s1 or not s2:
            return 0.0

        match_range = max(len(s1), len(s2)) // 2 - 1
        matches = 0
        transpositions = 0

        # Count matches
        for i, c in enumerate(s1):
            start = max(0, i - match_range)
            end = min(i + match_range + 1, len(s2))
            if c in s2[start:end]:
                matches += 1
                s2 = s2[:s2.index(c)] + '*' + s2[s2.index(c) + 1:]

        # Count transpositions
        for c1, c2 in zip(s1, s2):
            if c1 != c2 and c1 == '*':
                transpositions += 1

        if matches == 0:
            return 0.0

        jaro_similarity = (matches / len(s1) + matches / len(s2) + (matches - transpositions) / matches) / 3
        return jaro_similarity

    # Jaro-Winkler similarity
    jaro_similarity_value = jaro_similarity(content1, content2)
    prefix_length = 0

    for c1, c2 in zip(content1, content2):
        if c1 == c2:
            prefix_length += 1
        else:
            break

    jaro_winkler_similarity = jaro_similarity_value + prefix_scale * (prefix_length * (1 - jaro_similarity_value))

    return jaro_winkler_similarity


# Seuils de similarité
cosine_threshold = 0.8
jaccard_threshold = 0.6
levenshtein_threshold = 0.7
jaro_winkler_threshold = 0.9

# Répertoire racine
#root_directory = "/chemin/vers/votre/repertoire"
root_directory = "/home/xubuntu/work/110323/JSdataset"

#From Quelle2
#file_extensions = ['.js', '.vbs', '.ps1', '.htm','.html', '.php', '.py', '.rb', '.pl', '.txt', '.inc']
file_extensions = ['.js', '.vbs', '.ps1']
#MAXSIZE = 1000000  # Taille maximale en octets (1 Mo)
#MAXSIZE = 256000
#MAXSIZE = 8092
MAXSIZE = 4096
#MAXSIZE = 1024
#enc = 'utf-8'
#enc = 'utf-16'
enc = 'iso-8859-15'
#
# Initialise colorama
init()

# Fichier CSV
csv_filename = "similar_files.csv"

# Stockage des contenus dans un dictionnaire
file_contents = {}

print(f"{Back.BLUE}La lecture des contenus commence{Style.RESET_ALL}")

for root, dirs, files in os.walk(root_directory):
    for file in files:
        if file.endswith(tuple(file_extensions)) and os.path.getsize(os.path.join(root, file)) <= MAXSIZE:
            path = os.path.join(root, file)
            content = open(path, 'r', encoding=enc).read()
            file_contents[file] = content


print(f"{Back.BLUE}La lecture des contenus est terminee{Style.RESET_ALL}")
# Calcul des similarités
file_data = []

for file1, content1 in file_contents.items():
    for file2, content2 in file_contents.items():
        if file1 != file2:
            print(f"{Back.BLUE}"+file1+" <=> "+file2+"{Style.RESET_ALL}")
            cosine_sim = cosine_similarity(content1, content2)
            jaccard_sim = jaccard_similarity(content1, content2)
            levenshtein_sim = levenshtein_distance(content1, content2)
            jaro_winkler_sim = jaro_winkler_similarity(content1, content2)
            hamming_sim = hamming_similarity(content1, content2)

            # Vérification des seuils
            if (
                cosine_sim > cosine_threshold
                or jaccard_sim > jaccard_threshold
                or levenshtein_sim > levenshtein_threshold
                or jaro_winkler_sim > jaro_winkler_threshold
            ):
                print(f"{Back.RED}"+file1+" ~~~ "+file2+"{Style.RESET_ALL}")
                file_data.append((file1, file2, cosine_sim, jaccard_sim, levenshtein_sim, jaro_winkler_sim, hamming_sim))

# Écriture dans le fichier CSV
with open(csv_filename, 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    csv_writer.writerow(['File1', 'File2', 'Cosine Similarity', 'Jaccard Similarity', 'Levenshtein Distance', 'Jaro-Winkler Similarity', 'Hamming Similarity'])
    csv_writer.writerows(file_data)

print(f"Le fichier CSV {csv_filename} a été généré avec succès.")
