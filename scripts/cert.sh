#!/usr/bin/env sh
set -e

rm -rf nginx/.defaults/cert/*.pem

cd nginx/.defaults/cert
cfssl gencert -initca config.root.json | cfssljson -bare ca
cfssl gencert -ca ca.pem -ca-key ca-key.pem -config config.json -profile=server config.server.json | cfssljson -bare server
curl https://ssl-config.mozilla.org/ffdhe2048.txt > dhparam.pem

mv ca.pem chain.pem
mv server.pem cert.pem
mv server-key.pem privkey.pem
cat cert.pem chain.pem > fullchain.pem
rm -rf ca-key.pem
rm -rf *.csr
chmod 444 *.pem
