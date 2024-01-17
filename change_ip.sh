#!/bin/bash

ENV="./.env"

# Change IP address environment variable
update_env() {
	# Change value of IP address inside string
    sed -i 's/HOST=\".*\"/HOST=\"'"$1"'\"/' $2
}

# Get the new IP address and update the IP address environment variable
# 1 - Default Route "0.0.0.0"
# 2 - Localhost "127.0.0.1"
# 3 - Private IP Address "10.x.x.x|172.16.x.x|192.168.x.x"
change_ip() {
    case $1 in
        1) 
            echo "Changing honeypot IP address to default route"
            update_env "0.0.0.0" "$ENV"
            echo "IP address updated to 0.0.0.0"
            ;;
        2)
            echo "Changing honeypot IP address to localhost"
            update_env "127.0.0.1" "$ENV"
            echo "IP address updated to 127.0.0.1"
            ;;
        3)  
            priv_ip="$(hostname -I | awk '{print $1}')"
            echo "Changing honeypot IP address to private IP address"
            update_env "$priv_ip" "$ENV"
            echo "IP address updated to $priv_ip"
            ;;
        *)
            echo "Invalid string. IP address not changed"
    esac
}

change_ip $1
