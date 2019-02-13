strongswan
==========

[strongSwan][1] is an Open Source IPsec-based VPN solution for Linux and other
UNIX based operating systems implementing both the IKEv1 and IKEv2 key exchange
protocols.

This docker image was originally based on the `strongswan` Dockerfile from [2].

> :warning: This docker image only support IKEv2!

### docker-compose.yml

```yaml
version: '2'
services:
  strongswan:
    image: shushen/strongswan
    ports:
      - 500:500/udp
      - 4500:4500/udp
    volumes:
      - /lib/modules:/lib/modules
      - /etc/localtime:/etc/localtime
    environment:
      - VPN_DOMAIN=<your VPN server FQDN here>
      - VPN_COUNTRY=CA
      - VPN_ORGANIZATION="Example Co."
      - VPN_NETWORK=10.20.30.0/24
      - LAN_NETWORK=192.168.0.0/16
      - VPN_P12_PASSWORD=secret
    tmpfs: /run
    privileged: yes
    restart: always
```

### up and running

```bash
docker-compose up -d
docker cp strongswan_strongswan_1:/etc/ipsec.d/ca.cert.pem .
docker cp strongswan_strongswan_1:/etc/ipsec.d/client.mobileconfig .
docker cp strongswan_strongswan_1:/etc/ipsec.d/client.cert.p12 .
docker-compose logs -f
```

### add user to EAP-IKEv2

```bash
docker exec -it strongswan_strongswan_1 /add-vpn-user.sh <username> <password>
```

### Configuration files or certificates for clients:
- macOS/iOS: `client.mobileconfig`
- Android: `client.cert.p12`
- Root CA certificate for manual configuration: `ca.cert.pem`

[1]: https://strongswan.org/
[2]: https://github.com/vimagick/dockerfiles
