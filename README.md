Sidecar for registering treafik backend service by etcd
----

## Goal

- Register Traefik Backend dynamically through Etcd
- Register and unregister by Readiness check
- Non-intrusive code by docker Sidecar pattern

## Example

docker-compose:

```yaml
---
version: "3"

services:
  api:
    image: emilevauge/whoami
    restart: always

  api-traefik-sidecar:
    image: ccc13/traefik-etcd-sidecar:v0.0.3
    container_name: api_traefik_sidecar
    command:
      - "start"
      - "--etcd-endpoints=127.0.0.1:2379"
      - "--etcd-username=traefik"
      - "--etcd-password=traefik"
      - "--traefik-backend-name=api"
      - "--traefik-backend-node=node1"
      - "--traefik-backend-url=http://api:80"
      - "--traefik-backend-weight=1"
      - "--traefik-etcd-prefix=/traefik"
      - "--service-http-readiness-host=http://api"
      - "--service-http-readiness-port=80"
      - "--service-http-readiness-path=/ping"
      - "--service-http-readiness-interval=2"
    depends_on:
      - api
```

## Development

### Build

require Golang installed(**TODO** build by Docker)

```shell
make build-for-linux
```

### Package Docker Image

```shell
make docker-build-tag="latest" build-alpine-image
```

## License

MIT
