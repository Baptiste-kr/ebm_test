. .\global_var.ps1

# some cleaning
.\cleanup.ps1

# generate a root CA
.\generate_ca.ps1

# generate key/cert for a Box, a client and for encryption
.\generate_certificate.ps1 box BOX_EDC openssl-box-client.cnf
.\generate_certificate.ps1 client BOX_EDC openssl-box-client.cnf
.\generate_certificate.ps1 encrypt BOX_ENCRYPTION openssl-encryption.cnf

.\generate_certificate.ps1 revoked BOX_EDC openssl-box-client.cnf
.\revoke_certificate.ps1 ca/certs/revoked.pem

.\generate_crl.ps1 crl_01.pem


# convert pem to der if you want to use EBM TLS without TPM but with classical filesystem

# private keys
& $OPENSSL rsa -inform pem -in ca/certs/boxkey.pem -outform der -out box/box.key

# certs
& $OPENSSL x509 -outform der -in ca/certs/box.pem -out box/box.der
& $OPENSSL x509 -outform der -in ca/certs/encrypt.pem -out box/encrypt.der
& $OPENSSL x509 -outform der -in ca/ca.pem -out box/ca.der