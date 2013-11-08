#!/usr/bin/env sh

cer_file=$1
pem_file=${cer_file:0:-4}.pem

openssl x509 -in $cer_file -inform DER -outform PEM -out $pem_file