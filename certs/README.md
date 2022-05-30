# ExaminationBoxManager Standalone PKI

## Context 
ExaminationBoxManager can use a TLS connection, encrypt and sign transfered files. In order to do that, the application needs keys and certificates. 

This PKI is handled by ECS for the FS230 device. But if we want to test those features without ECS nor EDC, we need our own PKI. Here it is.

## Installation 

### prerequisites
* Windows and PowerShell

### Setup
* Clone this repository
* Launch a PowerShell console in the cloned repository with admin right
* Execute the command `Set-ExecutionPolicy unrestricted` in order to be able to execute the PowerShell scripts

## Description

The PKI is composed of a list of .ps1 scripts and 2 main folders.

### Folders hierachy
* `ca` : the base folder of the PKI, contains all the files to make things work
  * `certs` : all generated certificates and keys are stored here
  * `cnf` : contains the openssl configuration files
  * `crl` : not used
  * `vault` : internal folder
    * `new_certs` : 
  * `ca.pem` : the CA public certificate in PEM format (generated by `generate_ca.ps1`)
  * `cakey.pem` : the CA RSA private key in PKCS8 PEM format (generated by `generate_ca.ps1`)
  * `serial.txt` : internally used by openssl
  * `index.txt` : internally used by openssl
  * `crlnumber.txt` : internally used by openssl
* `openssl` : contains the openssl binaries
* `box` : will contain cert and key in DER format for installation in the ExaminationBoxManager standalone

## Usage

### Simple setup
If you simply need a bunch of certificates and keys to use with your client and a Box, simply run the `basic_setup.ps1` script.
It will generate the following files :
* `ca\ca.pem` & `ca\cakey.pem` : the CA certificate and private key
* `ca\certs\box.pem` & `ca\certs\boxkey.pem`
* `ca\certs\client.pem` & `ca\certs\clientkey.pem`
* `ca\certs\encrypt.pem` & `ca\certs\encryptkey.pem`
* `ca\certs\revoked.pem` & `ca\certs\revokedkey.pem`
* `crl_01.pem`

### Examples
See [Standalone PKI - EBS - Confluence (echosens.local)​​​​​​​](http://frpaconf01.echosens.local/display/COR/Standalone+PKI) for more examples