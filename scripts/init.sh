#!/bin/bash

set -e

rm -f .git/hooks/pre-commit
ln -s ../../scripts/pre-commit.sh .git/hooks/pre-commit

echo -n "What is your username? "
read username

if [ -z "$username" ]
then
  >&2 echo "You have to define a username!"
  exit 1
fi


if [ -d "vaults/$username" ]
then
  >&2 echo "This vault exists yet"
  exit 1
fi

vault="vaults/$username"
mkdir -p "$vault"

mkdir -p "$vault"/encrypted
touch "$vault"/encrypted/.gitkeep

mkdir -p "$vault"/notEncrypted
touch "$vault"/notEncrypted/.gitkeep



keyPrivate="hdrpKeyPrivate.pem"
keyPublic="hdrpKeyPublic.pem"

echo
echo -n "Define a password that you will give to the trustworthy person: "
read password

echo
echo "Generate private key"
openssl genrsa \
  -aes256 \
  -passout "pass:$password" \
  -out "$keyPrivate" \
  4096 > /dev/null


echo
echo "Generate public key"
openssl rsa \
  -in "$keyPrivate" \
  -passin "pass:$password" \
  -pubout \
  -out "$keyPublic" \
  -outform PEM > /dev/null


echo
echo "==============="
echo "=== WARNING ==="
echo "==============="
echo
echo
echo "The private key is in $keyPrivate"
echo
echo "1. the private key must be MOVED to a USB key, in a secured location"
echo "2. this location must be known by the trustworthy person"
echo "3. the private key's password (\"$password\") HAS TO BE known by the trustworthy person"
echo
echo -n "Press enter to continue..."
read

echo
echo "Your vault has been created."
echo "You can now add documents to $vault."
echo
echo "Files in encrypted/ directory will be encrypted (AES-256-CBC)."
echo "Files in notEncrypted/ directory will be stored in PLAIN TEXT."
