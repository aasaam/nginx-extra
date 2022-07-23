#!/usr/bin/env sh

rm -rf nginx/.defaults/cert/*.*

openssl genrsa -out nginx/.defaults/cert/root-key.pem 2048
openssl req -x509 -new -nodes -subj "/C=/ST=/L=/O=Nginx/CN=Embed Root CA" -key nginx/.defaults/cert/root-key.pem -sha256 -days 1024 -out nginx/.defaults/cert/root.pem

openssl genrsa -out nginx/.defaults/cert/localhost-key.pem 2048
openssl req -new -subj "/C=/ST=/L=/O=Nginx/CN=Embed Host" -key nginx/.defaults/cert/localhost-key.pem -out nginx/.defaults/cert/localhost.csr

openssl x509 -req -in nginx/.defaults/cert/localhost.csr -CA nginx/.defaults/cert/root.pem -CAkey nginx/.defaults/cert/root-key.pem -CAcreateserial -out nginx/.defaults/cert/localhost.pem -days 500 -sha256

cat nginx/.defaults/cert/root.pem > nginx/.defaults/cert/chain.pem
cat nginx/.defaults/cert/localhost.pem nginx/.defaults/cert/root.pem > nginx/.defaults/cert/fullchain.pem
cat nginx/.defaults/cert/localhost-key.pem > nginx/.defaults/cert/privkey.pem
curl -Ls https://ssl-config.mozilla.org/ffdhe2048.txt > nginx/.defaults/cert/dhparam.pem

rm -rf nginx/.defaults/cert/root*
rm -rf nginx/.defaults/cert/localhost*
