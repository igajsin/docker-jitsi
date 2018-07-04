#!/bin/sh

cd /etc/init.d

./prosody start \
    && ./jitsi-videobridge start \
    && ./jicofo start \
    && ./nginx start

/bin/tailf /var/log/jitsi/jvb.log
