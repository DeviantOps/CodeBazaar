# Lire le fichier texte contenant les en-têtes de l'e-mail

$headers = Get-Content "C:\Chemin\vers\fichier.txt"

 

# Liste des adresses IP suspectes

$suspiciousIPs = Get-Content "C:\Chemin\vers\fichier-IP.txt"

 

# Trouver l'en-tête "Received" qui contient les informations de suivi de l'e-mail

$receivedHeaders = $headers | Where-Object { $_ -match "^Received:" }

 

# Vérifier chaque en-tête "Received" pour détecter les problèmes potentiels

foreach ($receivedHeader in $receivedHeaders) {

    # Extraire l'adresse IP à partir de l'en-tête "Received"

    $ipMatch = [regex]::Match($receivedHeader, '\[(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\]')

    if ($ipMatch.Success) {

        $ip = $ipMatch.Groups[1].Value

        # Vérifier si l'adresse IP est sur la liste des adresses IP suspectes

        if ($suspiciousIPs -contains $ip) {

            Write-Warning "L'adresse IP $ip est suspecte. L'e-mail peut être frauduleux."

        }

    }

}

 

# Liste des domaines suspects

$suspiciousDomains = Get-Content "C:\Chemin\vers\fichier-domaine.txt"

 

# Trouver l'en-tête "Return-Path" qui contient l'adresse e-mail de l'expéditeur

$returnPathHeader = $headers | Where-Object { $_ -match "^Return-Path:" }

if ($returnPathHeader) {

   # Extraire l'adresse e-mail de l'expéditeur à partir de l'en-tête "Return-Path"

    $emailMatch = [regex]::Match($returnPathHeader, '<(.+?)>')

    if ($emailMatch.Success) {

        $email = $emailMatch.Groups[1].Value

        # Extraire le domaine de l'adresse e-mail de l'expéditeur

        $domain = $email.Split('@')[1]

        # Vérifier si le domaine est sur la liste des domaines suspects

        if ($suspiciousDomains -contains $domain) {

            Write-Warning "Le domaine $domain est suspect. L'e-mail peut être frauduleux."

        }

    }

}
