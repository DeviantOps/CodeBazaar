# Filtrage de Fichier
# Chemin d'accès du fichier texte contenant les données
$file_path = "C:\chemin\vers\fichier.txt"

# Expression régulière pour filtrer les lignes
$regex = "votre_expression_reguliere"

# Chemin d'accès pour le fichier de sortie
$output_path = "C:\chemin\vers\fichier_sortie.txt"

# Ouverture du fichier texte en lecture
$file = Get-Content $file_path

# Création d'un tableau vide pour stocker les lignes filtrées
$filtered_lines = @()

# Parcourir toutes les lignes du fichier
foreach ($line in $file) {

  # Si la ligne correspond à l'expression régulière ou si c'est la première ligne du fichier

  if ($line -match $regex -or $filtered_lines.Count -eq 0) {
    # Ajouter la ligne au tableau des lignes filtrées
    $filtered_lines += $line
  }

}

# Écriture des lignes filtrées dans le fichier de sortie
Set-Content $output_path $filtered_lines

 
