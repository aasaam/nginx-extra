#!/usr/bin/env sh

docker rm -f maxmind-lite-docker-test 2> /dev/null || true
docker run --name maxmind-lite-docker-test -d ghcr.io/aasaam/maxmind-lite-docker tail -f /dev/null
docker cp maxmind-lite-docker-test:/GeoLite2-City.mmdb ./nginx/.defaults/mmdb/GeoIP-City.mmdb
docker cp maxmind-lite-docker-test:/GeoLite2-ASN.mmdb ./nginx/.defaults/mmdb/GeoIP-ASN.mmdb
chmod 444 /tmp/GeoIP*
docker rm -f maxmind-lite-docker-test 2> /dev/null || true
