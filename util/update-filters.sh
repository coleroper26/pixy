#!/bin/bash
## executes on submission of filter update from apache2 webserver

# vars
SQUID_CONF="/etc/squid/squid.conf"
FILTERS=("advert" "bypass" "gambling" "illegal" "malware" "pornography" "torrent" "violence")

# sed replace
for ((i=1;i<=$#;i++)); do
    if [ "${!i}" = 1 ]; then
        sed -i "s/^# acl ${FILTERS[i-1]}/acl ${FILTERS[i-1]}/" $SQUID_CONF
        sed -i "s/^# http_access deny ${FILTERS[i-1]}/http_access deny ${FILTERS[i-1]}/" $SQUID_CONF
    else
        sed -i "s/^acl ${FILTERS[i-1]}/# acl ${FILTERS[i-1]}/" $SQUID_CONF
        sed -i "s/^http_access deny ${FILTERS[i-1]}/# http_access deny ${FILTERS[i-1]}/" $SQUID_CONF
    fi
done

# reconfigure squid with new content rules
# squid -k reconfigure

