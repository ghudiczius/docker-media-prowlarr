FROM mcr.microsoft.com/dotnet/runtime:6.0

ARG VERSION

RUN apt-get update && \
    apt-get --assume-yes install curl libsqlite3-0 && \
    groupadd --gid=1000 prowlarr && \
    useradd --gid=1000 --home-dir=/opt/prowlarr --no-create-home --shell /bin/bash --uid 1000 prowlarr && \
    mkdir /config /opt/prowlarr && \
    curl --location --output /tmp/prowlarr.tar.gz "https://github.com/prowlarr/prowlarr/releases/download/v${VERSION}/prowlarr.master.${VERSION}.linux-core-x64.tar.gz" && \
    tar xzf /tmp/prowlarr.tar.gz --directory=/opt/prowlarr --strip-components=1 && \
    chown --recursive 1000:1000 /config /opt/prowlarr && \
    rm /tmp/prowlarr.tar.gz

USER 1000
VOLUME /config
WORKDIR /opt/prowlarr

EXPOSE 9696
CMD ["/opt/prowlarr/Prowlarr", "-data=/config", "-nobrowser"]