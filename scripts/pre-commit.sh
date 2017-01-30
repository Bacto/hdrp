#!/bin/bash

set -e

if [ ! -f hdrpKeyPublic.pem ]
then
  >&2 echo "No public key found!"
  exit 1
fi

if [ -f hdrpKeyPrivate.pem ]
then
  >&2 echo "Private key hdrpKeyPrivate.pem found!"
  >&2 echo "You have to save it to a USB key and DELETE IT from your computer!"
  exit 1
fi

./scripts/encryptAllFiles.sh
git add vaults
