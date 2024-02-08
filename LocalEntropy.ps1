function LocalEntropy($data, $windowSize, $numBins) {
    $numElements = $data.Count
    $output = New-Object System.Collections.Generic.List[System.Double]
    for ($i = 0; $i -lt $numElements; $i++) {
        $start = [Math]::Max(0, $i - $windowSize + 1)
        $end = [Math]::Min($numElements - 1, $i)
        $subset = $data[$start..$end]
        $ent = Entropy $subset $numBins
        $output.Add($ent)
    }
    return $output
}
