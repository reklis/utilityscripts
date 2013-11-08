#!/usr/bin/env sh


p12_file=$1
pem_file=${p12_file:0:-4}.pem

openssl pkcs12 -in $p12_file -out $pem_file -nodes