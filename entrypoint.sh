#!/bin/sh
COUNTRY=${COUNTRY:-""}

reconnect(){
    if ! screen -ls >& /dev/null; then
        echo "E: Cound not connect any VPN servers in $COUNTRY"
        exit 1
    fi
    screen -S vpn -p 0 -X stuff "^Cy^M"
}
echo "COUNTRY: $COUNTRY"
echo "I: Wait for VPN connection"
screen -d -m -S vpn /app "$COUNTRY"

while true; do
    sleep 10
    if ! ip a | grep tun >& /dev/null; then
        echo "W: Try new server"
        reconnect
        continue
    fi

    echo "I: Check the DNS"
    if ! nslookup github.com >& /dev/null; then
        echo "W: DNS is not working. Try new server"
        reconnect
        continue
    fi
    echo "I: DNS is good"
    break
done

echo "I: The VPN is ready!"
wget -qO- http://ipinfo.io
sleep 1
printf "\nI: Execute %s" "$1"
exec "$@"
