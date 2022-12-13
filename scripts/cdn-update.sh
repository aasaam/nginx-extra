#!/usr/bin/env sh
set -e

CONFIG_DIR="./nginx/.defaults/cdn"

ALL_CDN_ALLOW="${CONFIG_DIR}/allow.all-cdn.conf"
ALL_CDN_REALIP="${CONFIG_DIR}/set_real_ip_from.all-cdn.conf"
echo "# autmatic generate [$(date)]" > $ALL_CDN_ALLOW
echo "# autmatic generate [$(date)]" > $ALL_CDN_REALIP

CLOUDFLARE_REALIP="${CONFIG_DIR}/set_real_ip_from.cloudflare.conf"
CLOUDFLARE_ALLOW="${CONFIG_DIR}/allow.cloudflare.conf"
CLOUDFLARE_IPS="https://www.cloudflare.com/ips-v4"
echo "# autmatic generate cloudflare ips $CLOUDFLARE_IPS [$(date)]" > $CLOUDFLARE_REALIP
cat $CLOUDFLARE_REALIP > $CLOUDFLARE_ALLOW
curl -Ls $CLOUDFLARE_IPS | while read line; do
  echo "set_real_ip_from $line;" >> $CLOUDFLARE_REALIP
  echo "set_real_ip_from $line;" >> $ALL_CDN_REALIP
  echo "allow $line;" >> $CLOUDFLARE_ALLOW
  echo "allow $line;" >> $ALL_CDN_ALLOW
done

ARVANCLOUD_REALIP="${CONFIG_DIR}/set_real_ip_from.arvancloud.conf"
ARVANCLOUD_ALLOW="${CONFIG_DIR}/allow.arvancloud.conf"
ARVANCLOUD_IPS="https://www.arvancloud.ir/fa/ips.txt"
echo "# autmatic generate cloudflare ips $ARVANCLOUD_IPS [$(date)]" > $ARVANCLOUD_REALIP
cat $ARVANCLOUD_REALIP > $ARVANCLOUD_ALLOW
curl -Ls $ARVANCLOUD_IPS | while read line; do
  echo "set_real_ip_from $line;" >> $ARVANCLOUD_REALIP
  echo "set_real_ip_from $line;" >> $ALL_CDN_REALIP
  echo "allow $line;" >> $ARVANCLOUD_ALLOW
  echo "allow $line;" >> $ALL_CDN_ALLOW
done

FASTLY_REALIP="${CONFIG_DIR}/set_real_ip_from.fastly.conf"
FASTLY_ALLOW="${CONFIG_DIR}/allow.fastly.conf"
FASTLY_IPS="https://api.fastly.com/public-ip-list"
echo "# autmatic generate fastly ips $FASTLY_IPS [$(date)]" > $FASTLY_REALIP
cat $FASTLY_REALIP > $FASTLY_ALLOW
curl -Ls $FASTLY_IPS | jq -r '.addresses | .[]' | while read line; do
  echo "set_real_ip_from $line;" >> $FASTLY_REALIP
  echo "set_real_ip_from $line;" >> $ALL_CDN_REALIP
  echo "allow $line;" >> $FASTLY_ALLOW
  echo "allow $line;" >> $ALL_CDN_ALLOW
done
