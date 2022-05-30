if($args.Count -ne 1)
{
	Write-Host "Usage : .\revoke_certificate.ps1 cert"
	Write-Host "        cert in PEM format that must be revoked."
	exit
}

. .\global_var.ps1

$name=$args[0]

& $OPENSSL ca -config $OPENSSL_CONF -revoke $name