FROM mcr.microsoft.com/dotnet/runtime:10.0-alpine3.22

ARG SOURCE_CHANNEL
ARG VERSION

# renovate: datasource=repology depName=alpine_3_22/curl versioning=loose
ENV CURL_VERSION=8.14.1-r1
# renovate: datasource=repology depName=alpine_3_22/icu-libs versioning=loose
ENV ICU_LIBS_VERSION=76.1-r1
# renovate: datasource=repology depName=alpine_3_22/sqlite-libs versioning=loose
ENV SQLITE_LIBS_VERSION=3.49.2-r1

RUN apk add --no-cache --update \
        curl="${CURL_VERSION}" \
        icu-libs="${ICU_LIBS_VERSION}" \
        sqlite-libs="${SQLITE_LIBS_VERSION}" && \
    addgroup -g 1000 prowlarr && \
    adduser -D -G prowlarr -h /opt/prowlarr -H -s /bin/sh -u 1000 prowlarr && \
    mkdir /config /opt/prowlarr && \
    curl --location --output /tmp/prowlarr.tar.gz "https://github.com/Prowlarr/Prowlarr/releases/download/v${VERSION}/Prowlarr.${SOURCE_CHANNEL}.${VERSION}.linux-musl-core-x64.tar.gz" && \
    tar xzf /tmp/prowlarr.tar.gz --directory=/opt/prowlarr --strip-components=1 && \
    chown --recursive 1000:1000 /config /opt/prowlarr && \
    rm /tmp/prowlarr.tar.gz

USER 1000
VOLUME /config
WORKDIR /opt/prowlarr

EXPOSE 9696
ENTRYPOINT ["/opt/prowlarr/Prowlarr"]
CMD ["-data=/config", "-nobrowser"]
