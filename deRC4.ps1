Function Deobfuscate-RC4 {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$CipherText,
        [Parameter(Mandatory=$true)]
        [string]$Key
    )

    $RC4 = New-Object System.Security.Cryptography.RC4CryptoServiceProvider
    $RC4.Key = [System.Text.Encoding]::ASCII.GetBytes($Key)
    $RC4.IV = [System.Text.Encoding]::ASCII.GetBytes($Key)

    $CipherBytes = [System.Convert]::FromBase64String($CipherText)
    $PlainText = [System.Text.Encoding]::UTF8.GetString($RC4.CreateDecryptor().TransformFinalBlock($CipherBytes, 0, $CipherBytes.Length))

    return $PlainText
}
