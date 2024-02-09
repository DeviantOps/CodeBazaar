# Lire le fichier texte contenant les en-têtes de l'e-mail

$headers = Get-Content "C:\Chemin\vers\fichier.txt"

 

# Trouver l'en-tête "Received" qui contient les informations de suivi de l'e-mail

$receivedHeaders = $headers | Where-Object { $_ -match "^Received:" }

 

# Vérifier chaque en-tête "Received" pour détecter les problèmes potentiels

foreach ($receivedHeader in $receivedHeaders) {

    # Extraire l'adresse IP à partir de l'en-tête "Received"

    $ipMatch = [regex]::Match($receivedHeader, '\[(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\]')

    if ($ipMatch.Success) {

        $ip = $ipMatch.Groups[1].Value

        # Vérifier si l'adresse IP est sur une liste noire

        $blacklist = Invoke-RestMethod "https://api.abuseipdb.com/api/v2/check?ipAddress=$ip" -Headers @{ "Key" = "votre-clef-API-ici"; "Accept" = "application/json" }

        if ($blacklist.data.isWhitelisted -ne "True") {

            Write-Warning "L'adresse IP $ip est sur la liste noire. L'e-mail peut être frauduleux."

        }

    }

}

 

# Trouver l'en-tête "Return-Path" qui contient l'adresse e-mail de l'expéditeur

$returnPathHeader = $headers | Where-Object { $_ -match "^Return-Path:" }

if ($returnPathHeader) {

    # Extraire l'adresse e-mail de l'expéditeur à partir de l'en-tête "Return-Path"

    $emailMatch = [regex]::Match($returnPathHeader, '<(.+?)>')

    if ($emailMatch.Success) {

        $email = $emailMatch.Groups[1].Value

        # Vérifier si l'adresse e-mail est sur une liste noire

        $blacklist = Invoke-RestMethod "https://api.abuseipdb.com/api/v2/check?emailAddress=$email" -Headers @{ "Key" = "votre-clef-API-ici"; "Accept" = "application/json" }

        if ($blacklist.data.isWhitelisted -ne "True") {

            Write-Warning "L'adresse e-mail $email est sur la liste noire. L'e-mail peut être frauduleux."

        }

    }

}
