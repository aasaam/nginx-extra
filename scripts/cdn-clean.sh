#!/usr/bin/env sh
set -e

find ./nginx/.defaults/cdn/allow.*.conf -exec truncate -s0 {} \;
find ./nginx/.defaults/cdn/set_real_ip_from.*.conf -exec truncate -s0 {} \;
