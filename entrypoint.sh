#!/bin/sh
exec 2>&1
if [[ -n ${PRIVOXY_INSTANCE} && "0" != ${PRIVOXY_INSTANCE} ]] ; then
  sed "s/^forward-socks5t\([^t]\+\)tor:9050\(.*\)/forward-socks5t\1tor:1905${PRIVOXY_INSTANCE}\2/" /etc/privoxy/config.template > /etc/privoxy/config
else
  cp etc/privoxy/config.template /etc/privoxy/config
fi
exec privoxy --no-daemon /etc/privoxy/config
