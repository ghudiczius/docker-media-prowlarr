# Prowlarr

Simple docker image for Prowlarr without any bloat, built on the official dotnet runtime image. Prowlarr runs as user `prowlarr` with `uid` and `gid` `1000` and listens on port `9696`.

## Usage

```sh
docker run --rm registry.gitlab.jmk.hu/media/prowlarr:<VERSION> \
  -p 9696:9696 \
  -v path/to/config:/config
```

or

```sh
docker run --rm ghudiczius/prowlarr:<VERSION> \
  -p 9696:9696 \
  -v path/to/config:/config
```
