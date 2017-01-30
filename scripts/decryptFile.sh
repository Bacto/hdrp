#!/bin/bash

set -e

if [ ! -f hdrpKeyPrivate.pem ]
then
  >&2 echo "You need to have the private key hdrpKeyPrivate.pem in `pwd`"
  exit 1
fi

file="$1"
echo "Decrypt file $file:"

passEncrypted=`cat $file | head -n 2 | tail -n 1`
pass=`echo $passEncrypted \
  | base64 -D \
  | openssl rsautl \
    -decrypt \
    -inkey hdrpKeyPrivate.pem`

encryptedContent=`cat $file | head -n 5 | tail -n 1`
content=`echo $encryptedContent \
  | base64 -D \
  | openssl enc \
    -d \
    -aes-256-cbc \
    -pass pass:$pass`

echo -e "$content"
