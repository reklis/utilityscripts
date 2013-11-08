#!/usr/bin/env bash

if [[ -z $1 ]]; then
  echo
  echo "usage: $0 private.pem authority.pem [domain]"
  echo
  echo "private.pem is your APNS cert from Apple exported from Keychain and converted from p12 to pem"
  echo "authority.pem is the Entrust CA (2048) root certificate"
  echo "domain (optional) an override, default: gateway.push.apple.com"
  echo
  echo "more info: https://developer.apple.com/library/ios/technotes/tn2265/_index.html"
  exit
fi

private_key=$1
authority_key=$2
domain="gateway.push.apple.com"

if [[ -n $3 ]]; then
  domain=$3
fi

openssl s_client -connect $domain:2195 -cert $private_key -debug -showcerts -CAfile $authority_key