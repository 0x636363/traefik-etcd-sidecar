docker-build-tag = "latest"

.PHONY: build-for-linux
build-for-linux:
	env GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -v

.PHONY: build-alpine-image
build-alpine-image: build-for-linux
	docker build . \
		--no-cache \
		--force-rm \
		-t ccc13/traefik-etcd-sidecar:$(docker-build-tag)

.PHONY: clean
clean:
	rm traefik-etcd-sidecar
