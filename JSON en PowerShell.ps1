# Charger le contenu du fichier JSON
$jsonContent = Get-Content -Path C:\example.json -Raw

# Convertir le contenu JSON en un objet PowerShell
$data = $jsonContent | ConvertFrom-Json

# Exemple de requête pour extraire des données spécifiques
$data.Users | Where-Object { $_.Age -lt 30 } | Select-Object Name, Age
