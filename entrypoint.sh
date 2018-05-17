#!/bin/sh
COUNTRY=${COUNTRY:-""}

echo "COUNTRY: $COUNTRY"
echo "I: Wait for VPN connection"
screen -d -m -S vpn /app "$COUNTRY"

sleep 15
while ! ip a | grep tun >& /dev/null; do
    if ! screen -ls >& /dev/null; then
        echo "E: Cound not connect any VPN server in $COUNTRY"
        exit 1
    fi
    screen -S vpn -p 0 -X stuff "y^M"
    echo "I: Try new the server"
    sleep 15
done

echo "I: The VPN is ready!"
sleep 5
wget -qO- http://ipinfo.io
sleep 1
exec "$@"
