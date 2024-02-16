Netscan Zero

# Définir le chemin du fichier texte contenant la liste des machines
$filePath = "C:\Chemin\Vers\Votre\Fichier.txt"

# Fonction pour récupérer les partages d'une machine
function Get-MachineShares {
    param (
        [string]$machine,
        [string]$username = $null,
        [string]$password = $null
    )

    # Définir les options pour la connexion WMI
    $options = $null
    if ($username -and $password) {
        $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
        $credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $securePassword
        $options = New-CimSessionOption -Credential $credentials
    }

    $shares = Get-WmiObject -Class Win32_Share -ComputerName $machine -ErrorAction SilentlyContinue -CimSessionOption $options
    if ($shares) {
        $shares | Select-Object Name, Path
    } else {
        Write-Output "Aucun partage n'a été trouvé sur $machine."
    }
}

# Lecture du fichier et traitement pour chaque machine
Get-Content $filePath | ForEach-Object {
    $machine = $_

    # Récupérer les partages avec le compte local
    $machineShares = Get-MachineShares -machine $machine

    if ($machineShares) {
        Write-Output "Partages sur $machine :"
        $machineShares
    } else {
        Write-Output "Impossible de se connecter à $machine ou aucun partage n'a été trouvé."
    }

    Write-Output "---------------------------------------"
}

Netscan 1

# Définir le chemin du fichier texte contenant la liste des machines
$filePath = "C:\Chemin\Vers\Votre\Fichier.txt"

# Définir le port TCP à tester (0 pour ignorer le test de connexion)
$portnum = 80

# Fonction pour récupérer les partages d'une machine
function Get-MachineShares {
    param (
        [string]$machine
    )

    $shares = Get-WmiObject -Class Win32_Share -ComputerName $machine -ErrorAction SilentlyContinue
    if ($shares) {
        $shares | Select-Object Name, Path
    } else {
        Write-Output "Aucun partage n'a été trouvé sur $machine."
    }
}

# Lecture du fichier et traitement pour chaque machine
Get-Content $filePath | ForEach-Object {
    $machine = $_
   
    # Récupérer les partages
    $machineShares = Get-MachineShares -machine $machine

    if ($machineShares) {
        Write-Output "Partages sur $machine :"
        $machineShares

        # Tester la connexion sur le port spécifié
        if ($portnum -ne 0) {
            $testConnection = Test-NetConnection -ComputerName $machine -Port $portnum
            Write-Output "Test de connexion sur le port $portnum pour $machine :"
            $testConnection
        }
    } else {
        Write-Output "Impossible de se connecter à $machine ou aucun partage n'a été trouvé."
    }

    Write-Output "---------------------------------------"
}

Netscan 2

# Définir le chemin du fichier texte contenant la liste des machines
$filePath = "C:\Chemin\Vers\Votre\Fichier.txt"

# Définir le port TCP à tester (0 pour ignorer le test de connexion)
$portnum = 80

# Définir le chemin du script PowerShell à exécuter sur les machines distantes
$localScriptPath = "C:\Chemin\Vers\Votre\CAD-Soft-update.lst"

# Fonction pour récupérer les partages d'une machine
function Get-MachineShares {
    param (
        [string]$machine
    )

    $shares = Get-WmiObject -Class Win32_Share -ComputerName $machine -ErrorAction SilentlyContinue
    if ($shares) {
        $shares | Select-Object Name, Path
    } else {
        Write-Output "Aucun partage n'a été trouvé sur $machine."
    }
}

# Lecture du fichier et traitement pour chaque machine
Get-Content $filePath | ForEach-Object {
    $machine = $_
   
    # Récupérer les partages
    $machineShares = Get-MachineShares -machine $machine

    if ($machineShares) {
        Write-Output "Partages sur $machine :"
        $machineShares

        # Exécuter le script distant sur chaque machine distante
        Write-Output "Exécution du script distant sur $machine :"
        Invoke-Command -ComputerName $machine -FilePath $localScriptPath
    } else {
        Write-Output "Impossible de se connecter à $machine ou aucun partage n'a été trouvé."
    }

    Write-Output "---------------------------------------"
}

