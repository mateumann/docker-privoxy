#!/bin/sh
exec 2>&1
sed "s/^forward-socks5t\([^t]\+\)tor:9050\(.*\)/forward-socks5t\1tor:1905${PRIVOXY_INSTANCE}\2/" /etc/privoxy/config.template > /etc/privoxy/config
exec privoxy --no-daemon /etc/privoxy/config
