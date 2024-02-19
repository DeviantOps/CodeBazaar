Function Deobfuscate-AES {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$CipherText,
        [Parameter(Mandatory=$true)]
        [string]$Key,
        [Parameter(Mandatory=$true)]
        [string]$IV
    )

    $AES = New-Object System.Security.Cryptography.AesCryptoServiceProvider
    $AES.Key = [System.Text.Encoding]::ASCII.GetBytes($Key)
    $AES.IV = [System.Text.Encoding]::ASCII.GetBytes($IV)

    $CipherBytes = [System.Convert]::FromBase64String($CipherText)
    $PlainText = [System.Text.Encoding]::UTF8.GetString($AES.CreateDecryptor().TransformFinalBlock($CipherBytes, 0, $CipherBytes.Length))

    return $PlainText
}
