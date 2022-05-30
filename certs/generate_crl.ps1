if($args.Count -gt 1)
{
	Write-Host "Usage : .\generate_crl.ps1 crlPath"
	Write-Host "        crlPath outpath of crl."
	exit
}

. .\global_var.ps1
$crlPath = "crl.pem"
if($args.Count -eq 1)
{
	$crlPath = $args[0]
}

& $OPENSSL ca -batch -config $OPENSSL_CONF -gencrl -out $crlPath
