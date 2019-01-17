# url-shortener-frontend

## Build Frontend Docker image
```
yarn build:docker
```

## Clone and build the API Docker image
See [API](https://github.com/eduardobcastro/url-shortener-api)

```
git clone https://github.com/eduardobcastro/url-shortener-api.git
cd url-shortener-api
yarn build:docker
```

## Start

```
docker swarm init

cat | docker stack deploy -c - url-shortener << 'EOF'
version: "3.3"
networks:
  shortener-net: null
services:
  couchdb:
    deploy:
      placement: { constraints: ["node.role == manager"] }
    image: "couchdb"
    networks:
      - shortener-net
    volumes:
      - "couchdb_data:/opt/couchdb/data"
  api:
    command: "yarn serve"
    depends_on:
      - couchdb
    deploy:
      restart_policy:
        condition: on-failure
    environment:
      - COUCHDB_URL=http://couchdb:5984
    image: url-shortener-api
    networks:
      - shortener-net
  front-end:
    depends_on:
      - "api"
    deploy:
      placement:
        constraints:
          - "node.role == manager"
    image: url-shortener-frontend
    networks:
      - shortener-net
    ports:
      - "0.0.0.0:80:80"
volumes:
  couchdb_data:
EOF

```