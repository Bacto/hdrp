#!/bin/bash

set -e

for file in `ls vaults/*/encrypted/* | grep -v "\.enc$"`
do
  ./scripts/encryptFile.sh "$file"
done
