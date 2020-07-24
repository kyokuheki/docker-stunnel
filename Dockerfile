FROM alpine:edge
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.comt>
ENV LANG="en_US.UTF-8"

RUN set -x \
 && apk add --no-cache \
    stunnel \
    libressl

RUN set -x \
 && mkdir -p -m 777 /run/stunnel \
 && chown root:stunnel /run/stunnel
# && install -v -o root -g stunnel -m 777 -d /run/stunnel

VOLUME /etc/stunnel

CMD set -x; \
    echo -e '\xef\xbb\xbf; BOM composed of non printable characters. It is here, before the semicolon!' > /stunnel.conf \
 && echo 'foreground = yes' >> /stunnel.conf \
 && cat /etc/stunnel/stunnel.conf >> /stunnel.conf \
 && cat /stunnel.conf \
 && /usr/bin/stunnel /stunnel.conf
