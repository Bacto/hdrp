#!/bin/bash

set -e

file="$1"
date=`date +%Y-%m-%d-%Hh%M`
echo "Encrypt file $file"

if [ -f $file-$date.enc ]
then
  >&2 echo "File $file-$date.enc exists yet!"
  exit 1
fi

pass=`openssl rand 256 -base64 | tr -d '\n'`
encryptedContent=`openssl enc \
  -e \
  -aes-256-cbc \
  -base64 \
  -pass pass:$pass \
  -in $file \
  | tr -d '\n'`
encryptedPass=`echo $pass \
  | openssl rsautl \
    -encrypt \
    -pubin -inkey hdrpKeyPublic.pem \
  | base64`


echo -e "-----BEGIN ENCRYPTED PASSWORD-----\n\
$encryptedPass\n\
-----END ENCRYPTED PASSWORD-----\n\
-----BEGIN ENCRYPTED FILE-----\n\
$encryptedContent\n\
-----END ENCRYPTED FILE-----" > $file-$date.enc

rm $file
