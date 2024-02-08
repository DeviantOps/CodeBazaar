function Entropy($data, $numBins) {
    $histogram = New-Object System.Collections.Generic.Dictionary[System.Double, System.Double]
    foreach ($value in $data) {
        $bin = [Math]::Floor(($value - [array]::Min($data)) / ([array]::Max($data) - [array]::Min($data)) * $numBins)
        if ($bin -ge $numBins) {
            $bin = $numBins - 1
        }
        if ($histogram.ContainsKey($bin)) {
            $histogram[$bin] += 1
        } else {
            $histogram[$bin] = 1
        }
    }
    $probs = $histogram.Values / $data.Count
    $logProbs = [Math]::Log($probs)
    $ent = -[array]::Sum($probs * $logProbs)
    return $ent
}
