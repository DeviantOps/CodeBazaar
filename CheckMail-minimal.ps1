# Lire le fichier texte contenant les en-têtes de l'e-mail

$headers = Get-Content "C:\Chemin\vers\fichier.txt"

 

# Trouver l'en-tête "Received" qui contient les informations de suivi de l'e-mail

$receivedHeaders = $headers | Where-Object { $_ -match "^Received:" }

 

# Extraire la dernière adresse IP à partir de l'en-tête "Received"

$lastReceivedHeader = $receivedHeaders[-1]

$lastIpMatch = [regex]::Match($lastReceivedHeader, '\[(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\]')

if ($lastIpMatch.Success) {

    $lastIp = $lastIpMatch.Groups[1].Value

    # Vérifier si l'adresse IP est une adresse IP locale

    if ($lastIp -eq "127.0.0.1" -or $lastIp -like "10.*" -or $lastIp -like "192.168.*" -or $lastIp -like "172.16.*") {

        Write-Warning "L'adresse IP $lastIp est une adresse IP locale. L'e-mail peut être frauduleux."

    }

}
