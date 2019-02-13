#!/bin/sh -e
#
USERNAME=$1
PASSWORD=$2

cat >> /etc/ipsec.d/ipsec.secrets <<_EOF_
${USERNAME} : EAP "${PASSWORD}"
_EOF_

