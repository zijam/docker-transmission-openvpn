#!/bin/sh

# Source our persisted env variables from container startup
. /etc/transmission/environment-variables.sh

# This script will be called with tun/tap device name as parameter 1, and local IP as parameter 4
# See https://openvpn.net/index.php/open-source/documentation/manuals/65-openvpn-20x-manpage.html (--up cmd)
echo "Updating TRANSMISSION_BIND_ADDRESS_IPV4 to the ip of $1 : $4"
export TRANSMISSION_BIND_ADDRESS_IPV4=$4

echo "Generating transmission settings.json from env variables"
# Ensure TRANSMISSION_HOME is created
mkdir -p "${TRANSMISSION_HOME}"
envsubst < "/etc/transmission/settings.tmpl" > "${TRANSMISSION_HOME}/settings.json"

if [ ! -e "/dev/random" ]; then
  # Avoid "Fatal: no entropy gathering module detected" error
  echo "INFO: /dev/random not found - symlink to /dev/urandom"
  ln -s /dev/urandom /dev/random
fi

echo "STARTING TRANSMISSION"
su abc -s /bin/sh --command="exec /usr/bin/transmission-daemon -g \"${TRANSMISSION_HOME}\" --logfile \"${TRANSMISSION_HOME}/transmission.log\" &"

echo "Transmission startup script complete."
