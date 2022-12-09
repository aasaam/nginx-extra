#!/usr/bin/env sh
set -e
cp /.defaults/ssl/profile.${ASM_NGX_EXTRA_SSL_PROFILE}.conf /.defaults/ssl/profile.runtime.conf
echo "SSL Profile: ${ASM_NGX_EXTRA_SSL_PROFILE} enabled by default."
envsubst "$(env | sed -e 's/=.*//' -e 's/^/\$/g')" < /template/nginx.conf > /etc/nginx/nginx.conf
exec "${@}"
