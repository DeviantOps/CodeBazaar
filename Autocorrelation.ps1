function Autocorrelation($data, $lag) {
    $numElements = $data.Count
    $mean = [array]::Average($data)
    $numerator = 0
    $denominator = 0
    for ($i = 0; $i -lt $numElements - $lag; $i++) {
        $numerator += ($data[$i] - $mean) * ($data[$i + $lag] - $mean)
    }
    for ($i = 0; $i -lt $numElements; $i++) {
        $denominator += [Math]::Pow(($data[$i] - $mean), 2)
    }
    if ($denominator -eq 0) {
        return 0
    }
    return $numerator / ($denominator * ($numElements - $lag))
}
