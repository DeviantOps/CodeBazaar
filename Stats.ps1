# Charger les deux fichiers CSV contenant les séries de données
$donnees1 = Import-Csv -Path "chemin/vers/fichier1.csv"
$donnees2 = Import-Csv -Path "chemin/vers/fichier2.csv"

# Convertir les colonnes de données en tableaux numériques
$tableau1 = $donnees1.Column1 | ForEach-Object { [double]$_ }
$tableau2 = $donnees2.Column1 | ForEach-Object { [double]$_ }

# Calculer les 5 premières grandeurs pour chaque série de données
$moyenne1 = $tableau1 | Measure-Object -Average | Select-Object -ExpandProperty Average
$moyenne2 = $tableau2 | Measure-Object -Average | Select-Object -ExpandProperty Average

$mediane1 = $tableau1 | Measure-Object -Median | Select-Object -ExpandProperty Median
$mediane2 = $tableau2 | Measure-Object -Median | Select-Object -ExpandProperty Median

$ecarttype1 = [Math]::Sqrt(($tableau1 | ForEach-Object { ($_ - $moyenne1) * ($_ - $moyenne1) } | Measure-Object -Sum).Sum / ($tableau1.Count - 1))
$ecarttype2 = [Math]::Sqrt(($tableau2 | ForEach-Object { ($_ - $moyenne2) * ($_ - $moyenne2) } | Measure-Object -Sum).Sum / ($tableau2.Count - 1))

$variance1 = $ecarttype1 * $ecarttype1
$variance2 = $ecarttype2 * $ecarttype2

$correlation = [Math]::Round([Math]::Round(($tableau1 | ForEach-Object { ($_ - $moyenne1) * ($_ - $moyenne2) } | Measure-Object -Sum).Sum / ($ecarttype1 * $ecarttype2 * ($tableau1.Count - 1)), 2), 2)

# Afficher les résultats
Write-Host "Série 1 :"
Write-Host "Moyenne : $moyenne1"
Write-Host "Médiane : $mediane1"
Write-Host "Écart-type : $ecarttype1"
Write-Host "Variance : $variance1"
Write-Host ""
Write-Host "Série 2 :"
Write-Host "Moyenne : $moyenne2"
Write-Host "Médiane : $mediane2"
Write-Host "Écart-type : $ecarttype2"
Write-Host "Variance : $variance2"
Write-Host ""
Write-Host "Coefficient de corrélation : $correlation"
