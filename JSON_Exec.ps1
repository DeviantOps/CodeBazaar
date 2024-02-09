# Lire le fichier JSON
$json = Get-Content -Raw -Path .\fonctions.json | ConvertFrom-Json

# Parcourir les fonctions et leurs paramètres
foreach ($fonction in $json.fonctions) {
    # Construire une chaîne de caractères pour appeler la fonction avec les paramètres
    $commande = "$($fonction.nom) "
    foreach ($parametre in $fonction.parametres) {
        $commande += "-$($parametre.nom) $($parametre.valeur) "
    }
    
    # Exécuter la commande en utilisant Invoke-Expression
    Invoke-Expression $commande
}

Avec le fichier JSON :

{
    "fonctions": [
        {
            "nom": "F1",
            "parametres": [
                {
                    "nom": "X1",
                    "valeur": "valeur_x1_f1"
                },
                {
                    "nom": "X2",
                    "valeur": "valeur_x2_f1"
                }
            ]
        },
        {
            "nom": "F2",
            "parametres": [
                {
                    "nom": "X1",
                    "valeur": "valeur_x1_f2"
                }
            ]
        },
        {
            "nom": "F3",
            "parametres": [
                {
                    "nom": "X1",
                    "valeur": "valeur_x1_f3"
                },
                {
                    "nom": "X2",
                    "valeur": "valeur_x2_f3"
                },
                {
                    "nom": "X3",
                    "valeur": "valeur_x3_f3"
                }
            ]
        }
    ]
}
