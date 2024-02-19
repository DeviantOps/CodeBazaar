Function Is-English($DecodedString) {
    $FrequencyTable = @{
        "e" = 12.7; "t" = 9.1; "a" = 8.2; "o" = 7.5; "i" = 7.0;
        "n" = 6.7; "s" = 6.3; "h" = 6.1; "r" = 6.0; "d" = 4.3;
        "l" = 4.0; "u" = 2.8; "c" = 2.8; "m" = 2.4; "w" = 2.4;
        "f" = 2.2; "g" = 2.0; "y" = 2.0; "p" = 1.9; "b" = 1.5;
        "v" = 1.0; "k" = 0.8; "j" = 0.2; "x" = 0.2; "q" = 0.1;
        "z" = 0.1;
    }
    $LetterCount = @{}
    $TotalChars = 0
    foreach ($Char in $DecodedString.ToLower()) {
        if ($Char -cmatch "[a-z]") {
            if (!$LetterCount.ContainsKey($Char)) {
                $LetterCount.Add($Char, 0)
            }
            $LetterCount[$Char]++
            $TotalChars++
        }
    }
    if ($TotalChars -lt 20) {
        return $false
    }
    $ChiSquared = 0
    foreach ($Letter in $FrequencyTable.Keys) {
        $ExpectedCount = $TotalChars * ($FrequencyTable[$Letter] / 100)
        $ObservedCount = $LetterCount.Get_Item($Letter)
        $Difference = $ObservedCount - $ExpectedCount
        $ChiSquared += ($Difference * $Difference) / $ExpectedCount
    }
    $DegreesOfFreedom = 25 - 1
    $CriticalValue = 37.652 # critical value for 24 degrees of freedom at alpha=0.05
    return $ChiSquared -lt $CriticalValue
}
