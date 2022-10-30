# Copyright (c) 2022 aasaam software development group
all:
	./scripts/geoip.sh
	./scripts/cdn-update.sh
	./scripts/cert.sh
