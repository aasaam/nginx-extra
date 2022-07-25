FROM alpine:edge

ENV ASM_NGX_EXTRA_ACCESS_LOG_COMMENT=""
ENV ASM_NGX_EXTRA_ERROR_LOG_LEVEL="warn"
ENV ASM_NGX_EXTRA_SEND_TIMEOUT="2"
ENV ASM_NGX_EXTRA_VARIABLES_HASH_MAX_SIZE="4096"
ENV ASM_NGX_EXTRA_KEEPALIVE_TIMEOUT="30"
ENV ASM_NGX_EXTRA_KEEPALIVE_REQUESTS="20480"
ENV ASM_NGX_EXTRA_CLIENT_BODY_TIMEOUT="4s"
ENV ASM_NGX_EXTRA_CLIENT_HEADER_TIMEOUT="4s"
ENV ASM_NGX_EXTRA_WORKER_PROCESSES="auto"
ENV ASM_NGX_EXTRA_WORKER_CONNECTIONS="2048"
ENV ASM_NGX_EXTRA_WORKER_RLIMIT_NOFILE="80000"
ENV ASM_NGX_EXTRA_SSL_STAPLING="on"
ENV ASM_NGX_EXTRA_SSL_STAPLING_VERIFY="on"
ENV ASM_NGX_EXTRA_PROXY_CACHE_FAST_SIZE="128m"
ENV ASM_NGX_EXTRA_PROXY_CACHE_SLOW_SIZE="4096m"
ENV ASM_NGX_EXTRA_PROXY_CACHE_FAST_COMMENT="#"
ENV ASM_NGX_EXTRA_PROXY_CACHE_SLOW_COMMENT="#"
ENV ASM_NGX_EXTRA_SSL_PROFILE="intermediate"
ENV ASM_NGX_EXTRA_MONITORING_PORT="8127"
ENV ASM_NGX_EXTRA_CLIENT_BODY_BUFFER_SIZE="256k"
ENV ASM_NGX_EXTRA_CLIENT_HEADER_BUFFER_SIZE="2k"
ENV ASM_NGX_EXTRA_LARGE_CLIENT_HEADER_BUFFERS="4 1k"

ENV ASM_NGX_EXTRA_MODULE_HTTP_ENCRYPTED_SESSION_COMMENT="#"
ENV ASM_NGX_EXTRA_MODULE_NCHAN_COMMENT="#"

ENV ASM_NGX_EXTRA_STREAM_COMMENT="#"


COPY nginx/.defaults /.defaults
COPY nginx/template /template
COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache \
  ca-certificates \
  gettext \
  nginx \
  nginx-mod-devel-kit \
  nginx-mod-http-brotli \
  nginx-mod-http-echo \
  nginx-mod-http-encrypted-session \
  nginx-mod-http-geoip2 \
  nginx-mod-http-headers-more \
  nginx-mod-http-nchan \
  nginx-mod-http-set-misc \
  nginx-mod-stream \
  nginx-mod-stream-geoip2 \
  && rm -rf /usr/share/nginx \
  && rm -rf /etc/logrotate.d/nginx \
  && rm -rf /etc/nginx \
  && mkdir -p /conf.d/stream \
  && mkdir -p /conf.d/http \
  && mkdir /etc/nginx \
  && chmod +x /entrypoint.sh \
  && nginx -V

EXPOSE 80/tcp 443/tcp

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "/bin/sh", "/entrypoint.sh" ]

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
