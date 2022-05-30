if($args.Count -eq 0)
{
	Write-Host "Usage : .\sign_csr.ps1 certName csrFile  extension"
	Write-Host "        certName name you want to give to your certificate. Will be store in PEM format."
	Write-Host "        csrFile is the CSR file to sign in PEM format."
	Write-Host "        extension (default is BOX_EDC)"
	exit
}

. .\global_var.ps1

$cert=$args[0]
$csr=$args[1]
$extension="BOX_EDC"
if($args.Count -eq 3)
{
	$extension=$args[2]
}

# sign it
& $OPENSSL ca -batch -config $OPENSSL_CONF -out $cert -extensions $extension -in $csr

Write-Host "Generated cert : " + $cert