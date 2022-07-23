#!/usr/bin/env sh
set -e
envsubst < /template/nginx.conf > /etc/nginx/nginx.conf
exec "${@}"
