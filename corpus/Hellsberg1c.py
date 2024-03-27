import os
import hashlib
import re
import math
from collections import defaultdict

# Fonction pour calculer la taille d'un repertoire
def get_directory_size(directory):
    total_size = 0
    for path, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(path, file)
            total_size += os.path.getsize(file_path)
    return total_size

# Fonction pour calculer l'entropie d'une chaîne de caractères
def entropy(string):
    prob = [float(string.count(c)) / len(string) for c in dict.fromkeys(list(string))]
    entropy = - sum([p * math.log(p) / math.log(2.0) for p in prob])
    return entropy

# Fonction pour calculer la simhash d'une chaîne de caractères
def simhash(string):
    sh = [0] * 128
    for word in string.split():
        word_hash = hashlib.md5(word.encode()).digest()
        for i in range(0, 16):
            bit = 1 << (7 - i % 8)
            sh[i] += (word_hash[i // 8] & bit and 1) or -1

    simhash_value = 0
    for i in range(0, 128):
        if sh[i] > 0:
            simhash_value |= 1 << (127 - i)

    return simhash_value

# Fonction pour calculer l'entropie informationnelle
def shannon(texte):
    # Calculer la frequence de chaque caractere dans le texte
    frequences = {char: texte.count(char) for char in set(texte)}

    # Calculer la probabilite de chaque caractere
    probabilites = [freq / len(texte) for freq in frequences.values()]

    # Calculer l'entropie informationnelle
    entropie_info = -sum(p * math.log2(p) for p in probabilites if p > 0)

    return entropie_info




# Fonction pour parcourir recursivement l'arborescence et collecter les statistiques
def collect_statistics(directory,MAXSIZE):
    #enc = 'utf-8'
    #enc = 'utf-16'
    enc = 'iso-8859-15'
    extensions_count = defaultdict(int)
    extensions_size = defaultdict(int)
    yaml_count = 0
    json_count = 0
    cfg_count = 0
    inc_count = 0
    ini_count = 0
    files_with_regex_match = []
    identical_md5_files = []
    SIMTHRESH=9

    # Charger les regex depuis le fichier texte
    with open("patterns.lst", "r") as f:
        regex_patterns = [re.compile(pattern.strip()) for pattern in f.readlines()]

    # Parcourir recursivement l'arborescence
    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            # Compter les extensions et leur taille
            _, extension = os.path.splitext(file_path)
            extensions_count[extension] += 1
            extensions_size[extension] += os.path.getsize(file_path)

            # Verifier les types de fichiers specifiques et leurs correspondances regex
            if extension == ".yml":
                yaml_count += 1
            elif extension == ".json":
                json_count += 1
            elif extension == ".cfg":
                cfg_count += 1
            elif extension == ".inc":
                inc_count += 1
            elif extension == ".ini":
                ini_count += 1

            if os.path.getsize(file_path) <= MAXSIZE:            
                # Verifier si le fichier correspond a une regex
                with open(file_path, "r",encoding=enc) as f:
                    content = f.read()
                    for pattern in regex_patterns:
                        if pattern.search(content):
                            files_with_regex_match.append(file_path)
                            break

                # Calculer l'empreinte MD5
                md5_hash = hashlib.md5()
                with open(file_path, "rb") as f:
                    for chunk in iter(lambda: f.read(4096), b""):
                        md5_hash.update(chunk)
                current_md5 = md5_hash.hexdigest()

                # Verifier si l'empreinte MD5 est identique a une de celles contenues dans un fichier texte
                with open("md5.lst", "r") as f:
                    md5_signatures = [line.strip() for line in f.readlines()]
                    if current_md5 in md5_signatures:
                        identical_md5_files.append(file_path)

                # Lecture du fichier pour les fonctions
                # gerant le contenu dans sa globalite
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, "r",encoding=enc) as f:
                        current_content = f.read()
                except ValueError: current_content = ""


                # Entropy
                current_entropy = entropy(current_content)
                
                # Shannon Entropy
                current_shannon = shannon(current_content)

                # SimHash
                current_simhash = simhash(current_content)
                
                print (current_md5+','+file_path.replace(',','_')+','+str(current_entropy)+','+str(current_shannon)+','+str(current_simhash))  
        
        
                   

    return (
        extensions_count,
        extensions_size,
        {"yml": yaml_count, "json": json_count, "cfg": cfg_count, "inc": inc_count, "ini": ini_count},
        files_with_regex_match,
        identical_md5_files
    )

ENTROPY = True
SIMHASH = True
# directory_path = "/home/xubuntu/work"
directory_path = "/media/xubuntu/eon2019/anomalies/zeta"
#MAXSIZE = 1000000  # Taille maximale en octets (1 Mo)
MAXSIZE = 256000
#MAXSIZE = 8092
#MAXSIZE = 4096

print ("MD5,PATH,ENTROPY,SHANNON,SIMHASH") 
extensions_count, extensions_size, specific_files_count, files_with_regex_match, identical_md5_files = collect_statistics(directory_path,MAXSIZE)

print ("*STATISTIQUES*")

print("Nombre de fichiers par extension:")
for ext, count in extensions_count.items():
    print(f"{ext}: {count}")

print("\nTaille par répertoire de premier niveau:")
print(get_directory_size(directory_path))

print("\nNombre de fichiers par type spécifique:")
for ext, count in specific_files_count.items():
    print(f"{ext}: {count}")

print("\nFichiers contenant des correspondances avec les regex:")
for file_path in files_with_regex_match:
    print(file_path)

print("\nFichiers ayant une signature MD5 identique:")
for file_path in identical_md5_files:
    print(file_path)
  
