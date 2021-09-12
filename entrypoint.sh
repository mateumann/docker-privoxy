#!/bin/sh
exec 2>&1
if [ -n ${PRIVOXY_INSTANCE} ] ; then
  sed "s/^forward-socks5t\([^t]\+\)tor:9050\(.*\)/forward-socks5t\1tor-${PRIVOXY_INSTANCE}:9050\2/" /etc/privoxy/config.template > /etc/privoxy/config
else
  cp etc/privoxy/config.template /etc/privoxy/config
fi
cd /etc/privoxy
for F in *.new ; do mv ${F} $( basename ${F} .new ) ; done
exec privoxy --no-daemon /etc/privoxy/config
