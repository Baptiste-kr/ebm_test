Param(
    [Parameter(Mandatory=$True,
	HelpMessage="File path to decrypt")]
    [ValidateNotNullOrEmpty()]
    [string]$inputFile,

    [Parameter(Mandatory=$True,
	HelpMessage="Local path to certs directory")]
    [ValidateNotNullOrEmpty()]
    [string]$localPath
)

$outputDir = "$localPath\tmp"
Write-Host "Start decrypting :" $inputFile "..."

# remove .enc extension
$origFileName = $inputFile.Substring(0, ($inputFile.Length - 4))
# Write-Host "original fileName : " $origFileName

$zipFile = "$origFileName.zip"
Copy-Item -Path "$inputFile" -Destination "$zipFile"

# Write-Host "Creating temporary folder..."
New-Item -ItemType directory -Path $outputDir

Expand-Archive -Path $zipFile -DestinationPath $outputDir

# decrypt aes initial vector using EncryptCert private key
# mapping between certuid.txt and EncryptCert is not done here.
cd $localPath
.\openssl\openssl.exe rsautl -decrypt -inkey certs\encryptkey.pem -in $outputDir\aeskey.hex.enc -out $outputDir\aeskey.hex

$aeskey = Get-Content -Path "$outputDir/aeskey.hex"
$aesiv = Get-Content -Path "$outputDir/aesiv.hex"
# Write-Host "loaded decrypted AES key : " $aeskey
# Write-Host "loaded AES iv : " $aesiv

# decrypt input
.\openssl\openssl.exe enc -d -aes256 -in $outputDir/data.enc -out $origFileName -K $aeskey -iv $aesiv

# Write-Host "Deleting temporary data..."
Remove-Item $outputDir -Recurse
Remove-Item $zipFile
Write-Host "Decription finished !"
