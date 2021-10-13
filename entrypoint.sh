#!/usr/bin/env sh

set -ex

# 支持 host.docker.internal
echo -e "`/sbin/ip route | awk '/default/ { print $3 }'`\thost.docker.internal" | tee -a /etc/hosts > /dev/null

/usr/bin/frps -v

case "$1" in
  frps)
    /usr/bin/frps -c /etc/frp/frps.ini
  ;;
  frpc)
    /usr/bin/frpc -c /etc/frp/frpc.ini
  ;;
  "")
    /usr/bin/frps -c /etc/frp/frps.ini
  ;;
esac
