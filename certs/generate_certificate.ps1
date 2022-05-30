if($args.Count -eq 0)
{
	Write-Host "Usage : .\generate_certificate.ps1 name extension csr_conf"
	Write-Host "        Certificate and key will be put in ca/certs/ folder."
	Write-Host "        extension (default is BOX_EDC)"
	Write-Host "        csr_conf (default is openssl-box-client.cnf). conf are looked in ./ca/cnf/ folder"
	exit
}

. .\global_var.ps1

$name=$args[0]
$extension="BOX_EDC"
$csr_conf="openssl-box-client.cnf"
if($args.Count -eq 3)
{
	$extension=$args[1]
	$csr_conf=$args[2]
}

$key = "$CA_DIR/certs/${name}key.pem"
$cert = "$CA_DIR/certs/$name.pem"

# generate CSR
& $OPENSSL req -config $CA_DIR/cnf/$csr_conf -subj "/C=FR/O=Echosens/OU=Fsppe/CN=Echosens/ST=France/L=Paris" -newkey rsa:2048 -sha256 -nodes -keyout $key -out cert.csr -outform PEM

# sign it
& $OPENSSL ca -batch -config $OPENSSL_CONF -out $cert -extensions $extension -in cert.csr

Write-Host "Generated cert : " + $cert
Write-Host "Generated key  : " + $key

Remove-Item cert.csr