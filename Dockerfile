FROM alpine:edge

ENV ASM_NGX_EXTRA_ACCESS_LOG_COMMENT="" \
  ASM_NGX_EXTRA_ERROR_LOG_LEVEL="warn" \
  ASM_NGX_EXTRA_SEND_TIMEOUT="2" \
  ASM_NGX_EXTRA_VARIABLES_HASH_MAX_SIZE="4096" \
  ASM_NGX_EXTRA_KEEPALIVE_TIMEOUT="30" \
  ASM_NGX_EXTRA_KEEPALIVE_REQUESTS="20480" \
  ASM_NGX_EXTRA_CLIENT_BODY_TIMEOUT="4s" \
  ASM_NGX_EXTRA_CLIENT_HEADER_TIMEOUT="4s" \
  ASM_NGX_EXTRA_WORKER_PROCESSES="auto" \
  ASM_NGX_EXTRA_WORKER_CONNECTIONS="2048" \
  ASM_NGX_EXTRA_WORKER_RLIMIT_NOFILE="80000" \
  ASM_NGX_EXTRA_PROXY_CACHE_FAST_SIZE="128m" \
  ASM_NGX_EXTRA_PROXY_CACHE_SLOW_SIZE="4096m" \
  ASM_NGX_EXTRA_PROXY_CACHE_FAST_COMMENT="" \
  ASM_NGX_EXTRA_PROXY_CACHE_SLOW_COMMENT="" \
  ASM_NGX_EXTRA_SSL_PROFILE="intermediate" \
  ASM_NGX_EXTRA_MONITORING_PORT="8127" \
  ASM_NGX_EXTRA_CLIENT_BODY_BUFFER_SIZE="256k" \
  ASM_NGX_EXTRA_CLIENT_HEADER_BUFFER_SIZE="2k" \
  ASM_NGX_EXTRA_RESOLVER="1.1.1.1 8.8.8.8 217.218.127.127 valid=600s ipv6=off" \
  ASM_NGX_EXTRA_RESOLVER_COMMENT="" \
  ASM_NGX_EXTRA_LARGE_CLIENT_HEADER_BUFFERS="4 1k" \
  ASM_NGX_EXTRA_MODULE_HTTP_ENCRYPTED_SESSION_COMMENT="#" \
  ASM_NGX_EXTRA_MODULE_NCHAN_COMMENT="#" \
  ASM_NGX_EXTRA_STREAM_COMMENT="#"

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
  nginx-mod-http-naxsi \
  nginx-mod-http-nchan \
  nginx-mod-http-set-misc \
  nginx-mod-stream \
  nginx-mod-stream-geoip2 \
  && rm -rf /usr/share/nginx \
  && rm -rf /etc/logrotate.d/nginx \
  && rm -rf /etc/nginx \
  && mkdir -p /conf.d/stream \
  && mkdir -p /conf.d/http \
  && mkdir -p /cache-fast \
  && chmod 777 /cache-fast \
  && mkdir -p /cache-slow \
  && chmod 777 /cache-slow \
  && mkdir /etc/nginx \
  && chmod +x /entrypoint.sh \
  && nginx -V

EXPOSE 80/tcp 443/tcp

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "/bin/sh", "/entrypoint.sh" ]

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
