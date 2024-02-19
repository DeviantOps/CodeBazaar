Function Deobfuscate-Xor($EncodedString, $Key) {
    $KeyBytes = [System.Text.Encoding]::UTF8.GetBytes($Key)
    $EncodedBytes = [System.Convert]::FromBase64String($EncodedString)
    $DecodedBytes = New-Object byte[] $EncodedBytes.Length
    for ($i = 0; $i -lt $EncodedBytes.Length; $i++) {
        $DecodedBytes[$i] = $EncodedBytes[$i] -bxor $KeyBytes[$i % $KeyBytes.Length]
    }
    $DecodedString = [System.Text.Encoding]::UTF8.GetString($DecodedBytes)
    return $DecodedString
}
