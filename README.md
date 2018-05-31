# vpn-torrent [![](https://images.microbadger.com/badges/image/txgvnn/vpn-torrent.svg)](https://microbadger.com/images/txgvnn/vpn-torrent)

Sometimes, I need to download some resources via torrent, and I usually use VPN connection for this, but I don't want to connect directly VPN in the host system.

So this is the idea from that.

## Usage
- If you like me, just for downloading via torrent

```
docker run -it --rm --cap-add=NET_ADMIN --device /dev/net/tun -v ~/Downloads:/data txgvnn/vpn-torrent rtorrent 'magnet:address' ...
```

Notes

```
-v ~/Downloads:/data - The /data is workdir, so files will be saved ~/Downloads
-e COUNTRY=US        - The selected country for VPN server (Default is automatic)
```

- You want more than just only rtorrent

You should rewrite the `Dockerfile` or `entrypoint.sh` for your purpose

## Thanks for
`Adhityaa` - Author of a [simple tool](https://github.com/adtac/autovpn) to automatically connect to VPN
