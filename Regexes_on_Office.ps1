# Chemin du fichier Office à décompresser
$cheminFichierOffice = "C:\chemin\vers\fichier.docx"

# Chemin du fichier texte contenant les regexes à vérifier
$cheminFichierRegex = "C:\chemin\vers\fichier_regex.txt"

# Création du dossier temporaire
$dossierTemporaire = New-Item -ItemType Directory -Path "$env:TEMP\OfficeDecompression\"

# Décompression du fichier Office dans le dossier temporaire
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($cheminFichierOffice, $dossierTemporaire)

# Recherche de tous les fichiers dans l'arborescence du dossier temporaire
$cheminsFichiers = Get-ChildItem $dossierTemporaire -Recurse | Where-Object {!($_.PSIsContainer)}

# Lecture des regexes à partir du fichier texte
$regexes = Get-Content $cheminFichierRegex

# Recherche de chaque regex dans le contenu de chaque fichier
foreach ($cheminFichier in $cheminsFichiers) {
    $contenuFichier = Get-Content $cheminFichier.FullName -Raw
    foreach ($regex in $regexes) {
        if ($contenuFichier -match $regex) {
            Write-Host "La regex '$regex' a été trouvée dans le fichier $($cheminFichier.FullName)"
        }
    }
}

# Suppression du dossier temporaire
Remove-Item $dossierTemporaire -Recurse -Force
