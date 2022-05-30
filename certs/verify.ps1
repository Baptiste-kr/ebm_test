Param(
    [Parameter(Mandatory=$True,
	HelpMessage="box PEM")]
    [ValidateNotNullOrEmpty()]
    [string]$certPath,

    [Parameter(Mandatory=$True,
	HelpMessage="fileToVerify filepath of the file to verify")]
    [ValidateNotNullOrEmpty()]
    [string]$inputFile,

    [Parameter(Mandatory=$True,
	HelpMessage="signatureToVerify must be in binary format")]
    [ValidateNotNullOrEmpty()]
    [string]$signature,

    [Parameter(Mandatory=$True,
	HelpMessage="Local path to certs directory")]
    [ValidateNotNullOrEmpty()]
    [string]$localPath
)

cd $localPath

# extract public key from certificate
.\openssl\openssl.exe x509 -pubkey -noout -in $certPath -out cert_pubkey.pem

# verify
.\openssl\openssl.exe dgst -binary -verify cert_pubkey.pem -signature $signature $inputFile

Remove-Item cert_pubkey.pem
