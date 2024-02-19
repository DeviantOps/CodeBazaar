Function Deobfuscate-AdditionCipher {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$CipherText,
        [Parameter(Mandatory=$true)]
        [int]$Key
    )

    $PlainText = ""
    $Chars = [System.Text.Encoding]::ASCII.GetBytes($CipherText)
    ForEach ($Char in $Chars) {
        $Decoded = [char]($Char - $Key)
        $PlainText += $Decoded
    }

    Return $PlainText
}
