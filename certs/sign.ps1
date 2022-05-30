Param(
    [Parameter(Mandatory=$True,
	HelpMessage="cakey.pem")]
    [ValidateNotNullOrEmpty()]
    [string]$privateKey,

    [Parameter(Mandatory=$True,
	HelpMessage="fileToSign file path to the file to sign")]
    [ValidateNotNullOrEmpty()]
    [string]$inputFile,

    [Parameter(Mandatory=$True,
	HelpMessage="signature output filename of the signature (will be stored in binary)")]
    [ValidateNotNullOrEmpty()]
    [string]$signature,

    [Parameter(Mandatory=$True,
	HelpMessage="Local path to certs directory")]
    [ValidateNotNullOrEmpty()]
    [string]$localPath
)

cd $localPath

.\openssl\openssl.exe dgst -binary -sha256 -sign $privateKey -out $signature $inputFile
