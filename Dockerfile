FROM igorgajsin/docker-base

COPY debconf-selections /
COPY ssl/fakechain.pem /etc/ssl/call.gajsin.name.crt
COPY ssl/fakekey.pem /etc/ssl/call.gajsin.name.key
COPY nginx/call.gajsin.name /etc/nginx/sites-enabled/call.gajsin.name
COPY nginx/default /etc/nginx/sites-enabled/default
COPY config.js /etc/jitsi/meet/config.js
COPY call.gajsin.name.cfg.lua /etc/prosody/conf.d/call.gajsin.name.cfg.lua
COPY run.sh /run.sh

RUN echo 'deb https://download.jitsi.org stable/' \
    >> /etc/apt/sources.list.d/jitsi-stable.list \
    && wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - \
    && /usr/bin/debconf-set-selections < /debconf-selections \
    && apt update \
    && apt install -y nginx \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
    jitsi-meet

EXPOSE 80
EXPOSE 443

CMD ["/run.sh"]
