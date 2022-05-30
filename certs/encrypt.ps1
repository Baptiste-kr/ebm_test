Param(
    [Parameter(Mandatory=$True,
	HelpMessage="File path to encrypt")]
    [ValidateNotNullOrEmpty()]
    [string]$inputFile

    [Parameter(Mandatory=$True,
	HelpMessage="Local path to certs directory")]
    [ValidateNotNullOrEmpty()]
    [string]$localPath
)

cd $localPath
$cert

$outputDir = "tmp"
Write-Host "Start encrypting " $inputFile "..."

Write-Host "Creating temporary folder..."
$null = New-Item -ItemType directory -Path $outputDir

# generate random key and initial vector
Write-Host "Generate key and initial vector for AES encryption..."
$aeskey = & $OPENSSL rand -hex 32 	# 256 bits or 32 bytes is the expected size of a KEY for AES256
$aesiv = & $OPENSSL rand -hex 16	# 16 bytes is the expected size a the initial vector for CBC (size of a CBC block) 
Write-Host "AES key : " $aeskey
Write-Host "AES iv  : " $aesiv

# encrypt input.txt
# openssl enc -aes256 -in $inputFile -out $outputDir/$inputFile.enc -K $aeskey -iv $iv -p #just to display some info
& $OPENSSL enc -aes256 -in $inputFile -out $outputDir/data.enc -K $aeskey -iv $aesiv

# let's encrypt the aeskey with the public key of ca_cert
Write-Host "Encrypting AES key with " $cert
$aeskey | Out-File -FilePath .\aeskey.hex
& $OPENSSL rsautl -encrypt -inkey $cert -certin -in aeskey.hex -out $outputDir\aeskey.hex.enc

# let's copy initial vector in output folder
$aesiv | Out-File -FilePath $outputDir\aesiv.hex

# extract x509v3-NetScapeComment and store it
# no easy way to do it with openssl therefor I already store it in a txt file
Copy-Item "certuid.txt" -Destination "$outputDir\certuid.txt"

Compress-Archive -Path $outputDir\* -DestinationPath "$inputFile.zip" -Force
Rename-Item -Path "$inputFile.zip" -NewName "$inputFile.enc"

Write-Host "Deleting temporary data..."
Remove-Item $outputDir -Recurse
Remove-Item aeskey.hex
Write-Host "Encryption finished !"
