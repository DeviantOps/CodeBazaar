$dirPath = "C:\chemin\du\repertoire"
$tlshBinary = "C:\analysis\tlsh\tlsh.exe"
$outputFilePath = "C:\chemin\du\fichier\de\sortie.csv"

# Create a new empty CSV file with headers
$header = "Nom du fichier","Date de modification","Taille du fichier","TLSH hash"
$output = @()
$output += $header | Out-String

Get-ChildItem -Path $dirPath -Recurse | ForEach-Object {

    if (!$_.PSIsContainer -and $_.Extension -eq ".exe") {
        $fileName = $_.Name
        $fileModified = $_.LastWriteTime
        $fileSize = $_.Length
        # Invoke the tlsh binary and capture the output
        $tlshOutput = & $tlshBinary $_.FullName
        # Create a new row for the CSV output
        $row = $fileName, $fileModified, $fileSize, $tlshOutput
        $output += $row | Out-String
    }
}
# Write the output to the CSV file
$output | Out-File $outputFilePath
