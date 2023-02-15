#!/bin/bash
# install openssl
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="openssl"
TYPE=".tar.gz"
FILE="$NAME$TYPE"
DOWNLOADURL="https://www.openssl.org/source/openssl-1.1.1d.tar.gz"
echo $NAME will be installed in "$ROOTDIR"

mkdir -p "$ROOTDIR/downloads"
cd "$ROOTDIR"

if [ -f "downloads/$FILE" ]; then
    echo "downloads/$FILE exist"
else
    echo "$FILE does not exist, downloading from $DOWNLOADURL"
    wget $DOWNLOADURL -O $FILE --no-check-certificate
    mv $FILE downloads/
fi

mkdir -p src/$NAME
tar xf downloads/$FILE -C src/$NAME --strip-components 1

cd src/$NAME

./config --prefix="$ROOTDIR"/ssl --openssldir="$ROOTDIR"/ssl
make -j"$(nproc)" && make install

echo $NAME installed on "$ROOTDIR"/ssl, with --openssldir="$ROOTDIR"/ssl
