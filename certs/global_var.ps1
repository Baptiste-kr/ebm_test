Set-Variable -Name CA_DIR -Value 'ca' -Scope Global
Set-Variable -Name OPENSSL_DIR -Value 'openssl' -Scope Global
Set-Variable -Name OPENSSL -Value .\$OPENSSL_DIR\openssl.exe -Scope Global
Set-Variable -Name OPENSSL_CONF -Value $CA_DIR/cnf/openssl-ca.cnf -Scope Global

& $OPENSSL version