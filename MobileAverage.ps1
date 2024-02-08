function MovingAverage($data, $windowSize) {
    $numElements = $data.Count
    $output = New-Object System.Collections.Generic.List[System.Double]
    for ($i = 0; $i -lt $numElements; $i++) {
        $start = [Math]::Max(0, $i - $windowSize + 1)
        $end = [Math]::Min($numElements - 1, $i)
        $sum = 0
        for ($j = $start; $j -le $end; $j++) {
            $sum += $data[$j]
        }
        $output.Add($sum / ($end - $start + 1))
    }
    return $output
}
