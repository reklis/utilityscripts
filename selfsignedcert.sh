#!/bin/sh

openssl req -new -x509 -nodes -out server.crt -keyout server.key

echo "Done."
echo ""
echo "Now you can add this to httpd.conf"
echo "	SSLCertificateFile    /path/to/this/server.crt"
echo "	SSLCertificateKeyFile /path/to/this/server.key"
