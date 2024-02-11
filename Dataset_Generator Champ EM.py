import csv
import random
import math

def generate_dataset(num_samples, filename):
    with open(filename, 'w', newline='') as csvfile:
        fieldnames = ['temps', 'x', 'y', 'z', 'intensite_electrique', 'intensite_magnetique', 
                      'vecteur_electrique_x', 'vecteur_electrique_y', 'vecteur_electrique_z', 
                      'vecteur_magnetique_x', 'vecteur_magnetique_y', 'vecteur_magnetique_z']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        for i in range(num_samples):
            temps = i / 1000  # Exemple de temps en secondes
            x = random.uniform(0, 100)  # Coordonnée x aléatoire
            y = random.uniform(0, 100)  # Coordonnée y aléatoire
            z = random.uniform(0, 100)  # Coordonnée z aléatoire

            intensite_electrique = math.sin(temps)  # Exemple d'intensité électrique (fonction trigonométrique)
            intensite_magnetique = math.cos(temps)  # Exemple d'intensité magnétique (fonction trigonométrique)

            vecteur_electrique = [0, 1, 0]  # Vecteur du champ électrique
            vecteur_magnetique = [0, 0, 1]  # Vecteur du champ magnétique

            writer.writerow({'temps': temps, 'x': x, 'y': y, 'z': z, 
                             'intensite_electrique': intensite_electrique, 'intensite_magnetique': intensite_magnetique, 
                             'vecteur_electrique_x': vecteur_electrique[0], 'vecteur_electrique_y': vecteur_electrique[1], 'vecteur_electrique_z': vecteur_electrique[2], 
                             'vecteur_magnetique_x': vecteur_magnetique[0], 'vecteur_magnetique_y': vecteur_magnetique[1], 'vecteur_magnetique_z': vecteur_magnetique[2]})

# Appel de la fonction pour générer le DataSet avec 8000 échantillons
generate_dataset(8000, 'dataset.csv')
