#!/bin/bash

# Check for root permissions
#if [[ "$EUID" -ne 0 ]]; then
#    echo "Please run as root."
#    exit 1
#fi

# Check for IP address argument
if [[ -z "$1" ]]; then
    echo "Usage: $0 <master_ip_address>"
    exit 1
fi

MASTER_IP="$1"
CONFIG_FILE="/etc/saunafs/sfschunkserver.cfg"
# Backup original config file
if [[ -f "$CONFIG_FILE" ]]; then
    cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
else
    echo "Config file not found: $CONFIG_FILE"
fi

# Modify or insert the MASTER_HOST line
if grep -q "^MASTER_HOST" "$CONFIG_FILE"; then
    sed -i "s/^MASTER_HOST.*/MASTER_HOST = $MASTER_IP/" "$CONFIG_FILE"
else
    echo "MASTER_HOST = $MASTER_IP" >> "$CONFIG_FILE"
fi
sed -i 's/(Default: *\([0-9]\+\), *Minimum: *[0-9]\+)/\#/' /etc/saunafs/sfschunkserver.cfg
cat $CONFIG_FILE
echo "Starting sfschunkserver..."
sfschunkserver -c $CONFIG_FILE -d start
