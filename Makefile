.SILENT:

.PHONY: build
build: build-back build-front

.PHONY: back
build-back:
	echo '🌙 build backend...'; \
	cd back && make all

.PHONY: build-front
build-front:
	echo '🌞 build frontend...'; \
	cd front

.PHONY: run
run: run-back

.PHONY: run-back

