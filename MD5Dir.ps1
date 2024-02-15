$dirPath = "C:\chemin\du\repertoire"

Get-ChildItem -Path $dirPath -Recurse | ForEach-Object {

    if (!$_.PSIsContainer) {

        Write-Host "Nom du fichier : $($_.Name)"

        Write-Host "Date de modification : $($_.LastWriteTime)"

        Write-Host "Taille du fichier : $($_.Length) octets"

        $hash = Get-FileHash $_.FullName -Algorithm MD5

        Write-Host "Hash MD5 : $($hash.Hash)"

        Write-Host " "

    }

}

 
