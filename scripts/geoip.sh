#!/usr/bin/env sh
set -e

docker pull ghcr.io/aasaam/maxmind-lite-docker
docker rm -f maxmind-lite-docker-test 2> /dev/null || true
docker run --name maxmind-lite-docker-test -d ghcr.io/aasaam/maxmind-lite-docker tail -f /dev/null
docker cp maxmind-lite-docker-test:/GeoLite2-City.mmdb ./nginx/.defaults/mmdb/GeoIP-City.mmdb
docker cp maxmind-lite-docker-test:/GeoLite2-ASN.mmdb ./nginx/.defaults/mmdb/GeoIP-ASN.mmdb
chmod 444 ./nginx/.defaults/mmdb/*.mmdb
docker rm -f maxmind-lite-docker-test 2> /dev/null || true
