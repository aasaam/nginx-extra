#!/usr/bin/env sh
set -e
cp /.defaults/ssl/profile.${ASM_NGX_EXTRA_SSL_PROFILE}.conf /.defaults/ssl/profile.runtime.conf
envsubst < /template/nginx.conf > /etc/nginx/nginx.conf
exec "${@}"
