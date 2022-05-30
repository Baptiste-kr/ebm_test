. .\global_var.ps1

# generate a self-signed CA
& $OPENSSL req -x509 -subj "/C=FR/O=Echosens/OU=Fsppe/CN=Echosens CA/ST=France/L=Paris" -newkey rsa:2048 -keyout $CA_DIR/cakey.pem -out $CA_DIR/ca.pem -days 36500 -nodes -config $OPENSSL_CONF