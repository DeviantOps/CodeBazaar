# Chemin d'accès au répertoire à analyser
$path = "C:\Path\To\Directory"

# Chemin d'accès au répertoire contenant les fichiers texte contenant les suites d'octets à rechercher
$patternsPath = "C:\Path\To\Patterns\Directory"

# Boucle sur tous les fichiers du répertoire à analyser
Get-ChildItem $path -Recurse | Where-Object { ! $_.PSIsContainer } | ForEach-Object {

    # Vérifie si le fichier est un fichier Office (docx, xlsx ou pptx)
    if($_.Extension -in ".docx",".xlsx",".pptx"){

        # Décompresse le fichier Office dans un répertoire temporaire
        $tempDir = New-Item -ItemType Directory -Path "$env:TEMP\$(New-Guid)"
        Expand-Archive -Path $_.FullName -DestinationPath $tempDir.FullName

        # Récupère la liste de tous les fichiers décompressés
        $files = Get-ChildItem $tempDir.FullName -Recurse

        # Boucle sur tous les fichiers décompressés et teste la présence de suites d'octets
        foreach($file in $files){
            # Boucle sur tous les fichiers texte contenant les suites d'octets à rechercher
            foreach($patternFile in Get-ChildItem $patternsPath -Filter "*.txt"){
                # Récupère la suite d'octets à rechercher à partir du fichier texte
                $pattern = Get-Content $patternFile.FullName | ForEach-Object { [byte[]] ([regex]::Matches($_, '\w\w') | ForEach-Object { [Convert]::ToByte($_.Value, 16) }) }

                # Recherche la suite d'octets dans le fichier
                $match = $pattern -eq (Get-Content $file.FullName -Encoding Byte)

                # Si la suite d'octets est présente, affiche le nom du fichier et la suite d'octets correspondante
                if($match){
                    Write-Output "Match found in $($file.FullName) : $($patternFile.Name)"
                }
            }
        }

        # Supprime le répertoire temporaire
        Remove-Item $tempDir.FullName -Recurse
    }
}
