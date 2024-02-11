# Liste des cibles

$computers = "computer1", "computer2", "computer3"

 

# Boucle sur chaque machine distante

foreach ($computer in $computers) {

 

    # Récupère les informations de mise à jour du système et les exporte dans un fichier CSV

    Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName $computer | Export-CSV -Path "C:\Temp\Updates_$computer.csv" -NoTypeInformation

 

    # Récupère les informations de disque et les exporte dans un fichier CSV

    Get-WmiObject -Class Win32_LogicalDisk -ComputerName $computer | Export-CSV -Path "C:\Temp\Disks_$computer.csv" -NoTypeInformation

 

    # Récupère les informations de processus et les exporte dans un fichier CSV

    Get-Process -ComputerName $computer | Export-CSV -Path "C:\Temp\Processes_$computer.csv" -NoTypeInformation

 

    # Récupère les informations de tâches planifiées et les exporte dans un fichier CSV

    Get-ScheduledTask -ComputerName $computer | Export-CSV -Path "C:\Temp\ScheduledTasks_$computer.csv" -NoTypeInformation

 

    # Récupère les informations d'autoruns et les exporte dans un fichier CSV

    Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -ComputerName $computer | Export-CSV -Path "C:\Temp\Autoruns_$computer.csv" -NoTypeInformation

}
