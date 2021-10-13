FROM alpine:latest

LABEL maintainer="lll9p <lll9p.china@gmail.com>"

ENV FRP_VERSION 0.37.1

COPY ./entrypoint.sh /entrypoint.sh

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
        x86_64) binArch='amd64' ;; \
	armv6|armv7) binArch='arm' ;; \
	aarch64) binArch='arm64' ;; \
	ppc64el|ppc64le) binArch='ppc64le' ;; \
	*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
    esac; \
    wget --no-check-certificate -c https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${binArch}.tar.gz; \
    pushd; \
    tar zxvf frp_${FRP_VERSION}_linux_${binArch}.tar.gz; \
    cd frp_${FRP_VERSION}_linux_${binArch}/ ; \
    cp frps /usr/bin/ ; \
    mkdir -p /etc/frp ; \
    cp frps.ini /etc/frp ; \
    popd ; \
    rm frp_${FRP_VERSION}_linux_${binArch}.tar.gz ; \
    rm -rf frp_${FRP_VERSION}_linux_${binArch}/

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
