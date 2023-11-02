#!/usr/bin/env sh

echo "frp version is: $(/usr/bin/frps -v)"

set -ex

# 支持 host.docker.internal
echo -e "$(/sbin/ip route | awk '/default/ { print $3 }')\thost.docker.internal" | tee -a /etc/hosts >/dev/null

case "$1" in
frps)
	/usr/bin/frps -c /etc/frp/frps.toml
	;;
frpc)
	/usr/bin/frpc -c /etc/frp/frpc.toml
	;;
"")
	/usr/bin/frps -c /etc/frp/frps.toml
	;;
esac
