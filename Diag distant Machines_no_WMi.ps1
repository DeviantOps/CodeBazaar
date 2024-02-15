$computers = "computer1", "computer2", "computer3"

 

foreach ($computer in $computers) {

    Write-Host "Collecting information from $computer..."

   

    # Collect process information

    $processes = Invoke-Command -ComputerName $computer -ScriptBlock { Get-Process }

    $malware = $processes | where {$_.Name -match "malware1|malware2|malware3"}

    if ($malware) {

        Write-Host "Malware detected on $computer: $($malware.Name)"

    }

   

    # Collect event log information

    $eventLogs = Invoke-Command -ComputerName $computer -ScriptBlock { Get-EventLog -LogName "Application" -Newest 50 }

    $errors = $eventLogs | where {$_.EntryType -eq "Error"}

    if ($errors) {

        Write-Host "Errors detected in the event log on $computer"

        $errors | select MachineName, TimeGenerated, Source, Message

    }

   

    # Collect certificate information

    $certificates = Invoke-Command -ComputerName $computer -ScriptBlock { Get-ChildItem -Path Cert:\LocalMachine\My }

    if ($certificates) {

        Write-Host "Certificates found on $computer"

        $certificates | select Subject, Thumbprint, FriendlyName, NotBefore, NotAfter

    }

   

    # Collect scheduled task information

    $scheduledTasks = Invoke-Command -ComputerName $computer -ScriptBlock { Get-ScheduledTask }

    if ($scheduledTasks) {

        Write-Host "Scheduled tasks found on $computer"

        $scheduledTasks | select TaskName, State, LastRunTime, NextRunTime, Description

    }

}
