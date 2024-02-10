import json
import csv
import random
import math

def generate_dataset(num_rows, column_functions):
    dataset = []

    for _ in range(num_rows):
        row = [func() for func in column_functions]
        dataset.append(row)

    return dataset

def save_to_csv(dataset, filename):
    with open(filename, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerows(dataset)

def load_json_definition(json_filename):
    with open(json_filename, 'r') as json_file:
        definition = json.load(json_file)
    return definition

def main():
    # Charger la définition du dataset depuis un fichier JSON
    dataset_definition = load_json_definition('dataset_definition.json')

    # Extraire les paramètres
    num_rows = dataset_definition['num_rows']
    column_functions = dataset_definition['column_functions']

    # Générer le dataset
    dataset = generate_dataset(num_rows, column_functions)

    # Enregistrer le dataset dans un fichier CSV
    save_to_csv(dataset, 'dataset_test.csv')

if __name__ == "__main__":
    main()

Avec le .JSON:

{
    "num_rows": 8000,
    "column_functions": [
        "random.uniform(0, 10)",
        "random.normalvariate(5, 2)",
        "random.randint(1, 100)",
        "math.sin(random.uniform(0, 2*math.pi))",
        "math.cos(random.uniform(0, 2*math.pi))",
        "math.exp(random.uniform(0, 5))"
    ]
}
