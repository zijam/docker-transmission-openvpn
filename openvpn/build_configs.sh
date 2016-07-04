#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

display_usage() {
  echo "${bold}Hint: read the script before using it${normal}"
  echo "If you just forgot: ./adjustConfigs.sh <provider-folder>"
}

# if no arguments supplied, display usage
if [  $# -lt 1 ]
then
  display_usage
  exit 1
fi

provider=$1

# Downloaded list from https://controlpanel.newshosting.com/customer/action/vpnserverlist.php using this javascript
#
# var servers = [];
# var nodelist = $('#serverlist>tbody>tr');
# nodes = Array.prototype.slice.call(nodelist,0);
# nodes.forEach(function(td) {
#   servers.push(td.children[2].innerText);
# });
# copy("\""+servers.join("\" \"")+"\"");
#
servers=( "atl-a01.wlvpn.com" "atl-a02.wlvpn.com" "atl-a03.wlvpn.com" "atl-a04.wlvpn.com" "atl-a05.wlvpn.com" "atl-a06.wlvpn.com" "atl-a07.wlvpn.com" "atl-a08.wlvpn.com" "atl-a09.wlvpn.com" "atl-a10.wlvpn.com" "atl-a11.wlvpn.com" "atl-a12.wlvpn.com" "atl-a13.wlvpn.com" "atl-a14.wlvpn.com" "atl-a15.wlvpn.com" "atl-a16.wlvpn.com" "chi-a01.wlvpn.com" "chi-a02.wlvpn.com" "chi-a03.wlvpn.com" "chi-a04.wlvpn.com" "chi-a05.wlvpn.com" "chi-a06.wlvpn.com" "chi-a07.wlvpn.com" "chi-a08.wlvpn.com" "chi-a09.wlvpn.com" "chi-a10.wlvpn.com" "chi-a11.wlvpn.com" "chi-a12.wlvpn.com" "chi-a13.wlvpn.com" "chi-a14.wlvpn.com" "chi-a15.wlvpn.com" "chi-a16.wlvpn.com" "dal-a01.wlvpn.com" "dal-a02.wlvpn.com" "dal-a03.wlvpn.com" "dal-a04.wlvpn.com" "dal-a05.wlvpn.com" "dal-a06.wlvpn.com" "dal-a07.wlvpn.com" "dal-a08.wlvpn.com" "dal-a09.wlvpn.com" "dal-a10.wlvpn.com" "dal-a11.wlvpn.com" "dal-a12.wlvpn.com" "dal-a13.wlvpn.com" "dal-a14.wlvpn.com" "iad-a01.wlvpn.com" "iad-a02.wlvpn.com" "iad-a03.wlvpn.com" "iad-a04.wlvpn.com" "iad-a05.wlvpn.com" "iad-a06.wlvpn.com" "iad-a07.wlvpn.com" "iad-a08.wlvpn.com" "iad-a09.wlvpn.com" "iad-a10.wlvpn.com" "iad-a11.wlvpn.com" "iad-a12.wlvpn.com" "iad-a13.wlvpn.com" "iad-a14.wlvpn.com" "iad-a15.wlvpn.com" "iad-a16.wlvpn.com" "lax-a01.wlvpn.com" "lax-a02.wlvpn.com" "lax-a03.wlvpn.com" "lax-a04.wlvpn.com" "lax-a05.wlvpn.com" "lax-a06.wlvpn.com" "lax-a07.wlvpn.com" "lax-a08.wlvpn.com" "lax-a09.wlvpn.com" "lax-a10.wlvpn.com" "lax-a11.wlvpn.com" "lax-a12.wlvpn.com" "lax-a13.wlvpn.com" "lax-a14.wlvpn.com" "lax-a15.wlvpn.com" "lax-a16.wlvpn.com" "lax-a17.wlvpn.com" "lax-a18.wlvpn.com" "mia-a01.wlvpn.com" "mia-a02.wlvpn.com" "mia-a03.wlvpn.com" "mia-a04.wlvpn.com" "mia-a05.wlvpn.com" "mia-a06.wlvpn.com" "mia-a07.wlvpn.com" "mia-a08.wlvpn.com" "mia-a09.wlvpn.com" "mia-a10.wlvpn.com" "mia-a12.wlvpn.com" "mia-a13.wlvpn.com" "mia-a15.wlvpn.com" "mia-a16.wlvpn.com" "nyc-a01.wlvpn.com" "nyc-a02.wlvpn.com" "nyc-a03.wlvpn.com" "nyc-a04.wlvpn.com" "nyc-a05.wlvpn.com" "nyc-a06.wlvpn.com" "nyc-a07.wlvpn.com" "nyc-a08.wlvpn.com" "nyc-a09.wlvpn.com" "nyc-a10.wlvpn.com" "nyc-a12.wlvpn.com" "nyc-a13.wlvpn.com" "nyc-a14.wlvpn.com" "nyc-a15.wlvpn.com" "nyc-a16.wlvpn.com" "nyc-a17.wlvpn.com" "nyc-a18.wlvpn.com" "nyc-a19.wlvpn.com" "nyc-a20.wlvpn.com" "nyc-a21.wlvpn.com" "nyc-a22.wlvpn.com" "nyc-a23.wlvpn.com" "nyc-a24.wlvpn.com" "nyc-a25.wlvpn.com" "nyc-a26.wlvpn.com" "nyc-a27.wlvpn.com" "phx-a01.wlvpn.com" "phx-a02.wlvpn.com" "phx-a03.wlvpn.com" "phx-a04.wlvpn.com" "phx-a06.wlvpn.com" "sea-a01.wlvpn.com" "sea-a02.wlvpn.com" "sea-a03.wlvpn.com" "sea-a04.wlvpn.com" "sea-a05.wlvpn.com" "sea-a06.wlvpn.com" "sea-a07.wlvpn.com" "sea-a08.wlvpn.com" "sea-a09.wlvpn.com" "sea-a10.wlvpn.com" "sea-a11.wlvpn.com" "sea-a12.wlvpn.com" "sea-a13.wlvpn.com" "sea-a14.wlvpn.com" "sea-a15.wlvpn.com" "sjc-a01.wlvpn.com" "sjc-a02.wlvpn.com" "sjc-a03.wlvpn.com" "sjc-a04.wlvpn.com" "sjc-a05.wlvpn.com" "sjc-a06.wlvpn.com" "sjc-a07.wlvpn.com" "sjc-a08.wlvpn.com" "sjc-a09.wlvpn.com" "sjc-a10.wlvpn.com" "sjc-a11.wlvpn.com" "sjc-a12.wlvpn.com" "sjc-a13.wlvpn.com" "sjc-a14.wlvpn.com" "sjc-a15.wlvpn.com" "lon-a01.wlvpn.com" "lon-a02.wlvpn.com" "lon-a03.wlvpn.com" "lon-a04.wlvpn.com" "lon-a05.wlvpn.com" "lon-a06.wlvpn.com" "lon-a07.wlvpn.com" "lon-a08.wlvpn.com" "lon-a09.wlvpn.com" "lon-a10.wlvpn.com" "lon-a11.wlvpn.com" "lon-a12.wlvpn.com" "lon-a13.wlvpn.com" "lon-a14.wlvpn.com" "lon-a15.wlvpn.com" "lon-a16.wlvpn.com" "lon-a17.wlvpn.com" "lon-a18.wlvpn.com" "lon-a19.wlvpn.com" "lon-a20.wlvpn.com" "lon-a21.wlvpn.com" "lon-a22.wlvpn.com" "lon-a23.wlvpn.com" "lon-a24.wlvpn.com" "lon-a25.wlvpn.com" "lon-a26.wlvpn.com" "man-c04.wlvpn.com" "man-c05.wlvpn.com" "sin-a01.wlvpn.com" "sin-a02.wlvpn.com" "sin-a03.wlvpn.com" "sin-a04.wlvpn.com" "sin-a05.wlvpn.com" "sin-a06.wlvpn.com" "sin-a07.wlvpn.com" "sin-a08.wlvpn.com" "sin-a09.wlvpn.com" "sin-a10.wlvpn.com" "sin-a11.wlvpn.com" "sin-a12.wlvpn.com" "sto-a01.wlvpn.com" "sto-a02.wlvpn.com" "sto-a03.wlvpn.com" "sto-a04.wlvpn.com" "sto-a05.wlvpn.com" "sto-a06.wlvpn.com" "sto-a07.wlvpn.com" "sto-a08.wlvpn.com" "sto-a09.wlvpn.com" "sto-a10.wlvpn.com" "sto-a11.wlvpn.com" "sto-a12.wlvpn.com" "sto-b01.wlvpn.com" "waw-b01.wlvpn.com" "ams-a01.wlvpn.com" "ams-a02.wlvpn.com" "ams-a03.wlvpn.com" "ams-a04.wlvpn.com" "ams-a05.wlvpn.com" "ams-a06.wlvpn.com" "ams-a07.wlvpn.com" "ams-a08.wlvpn.com" "ams-a09.wlvpn.com" "ams-a10.wlvpn.com" "ams-a11.wlvpn.com" "ams-a12.wlvpn.com" "ams-a13.wlvpn.com" "ams-a14.wlvpn.com" "ams-a15.wlvpn.com" "ams-a16.wlvpn.com" "ams-a17.wlvpn.com" "ams-a18.wlvpn.com" "ams-a19.wlvpn.com" "ams-a20.wlvpn.com" "ams-a21.wlvpn.com" "ams-a22.wlvpn.com" "ams-a23.wlvpn.com" "ams-a24.wlvpn.com" "ams-a25.wlvpn.com" "ams-a26.wlvpn.com" "ams-a27.wlvpn.com" "ams-a28.wlvpn.com" "ams-a29.wlvpn.com" "ams-a30.wlvpn.com" "ams-a31.wlvpn.com" "ams-a32.wlvpn.com" "ams-a33.wlvpn.com" "ams-a34.wlvpn.com" "ams-a35.wlvpn.com" "ams-a36.wlvpn.com" "ams-a37.wlvpn.com" "ams-a38.wlvpn.com" "ams-a39.wlvpn.com" "ams-a40.wlvpn.com" "ams-a41.wlvpn.com" "lux-c02.wlvpn.com" "lux-c03.wlvpn.com" "sel-a01.wlvpn.com" "sel-a04.wlvpn.com" "sel-a06.wlvpn.com" "nrt-a01.wlvpn.com" "nrt-a02.wlvpn.com" "nrt-a03.wlvpn.com" "nrt-a04.wlvpn.com" "nrt-a05.wlvpn.com" "nrt-a06.wlvpn.com" "bud-b01.wlvpn.com" "par-a01.wlvpn.com" "par-a02.wlvpn.com" "par-a03.wlvpn.com" "par-a04.wlvpn.com" "par-a05.wlvpn.com" "par-a06.wlvpn.com" "par-a07.wlvpn.com" "par-a08.wlvpn.com" "par-a09.wlvpn.com" "par-a10.wlvpn.com" "par-a11.wlvpn.com" "par-a12.wlvpn.com" "mad-a01.wlvpn.com" "mad-a02.wlvpn.com" "fra-a01.wlvpn.com" "fra-a02.wlvpn.com" "fra-a03.wlvpn.com" "fra-a04.wlvpn.com" "fra-a05.wlvpn.com" "fra-a06.wlvpn.com" "fra-a07.wlvpn.com" "fra-a08.wlvpn.com" "fra-a09.wlvpn.com" "fra-a10.wlvpn.com" "fra-a11.wlvpn.com" "fra-a12.wlvpn.com" "fra-a13.wlvpn.com" "fra-a14.wlvpn.com" "fra-a15.wlvpn.com" "fra-a16.wlvpn.com" "fra-a17.wlvpn.com" "fra-a18.wlvpn.com" "fra-a19.wlvpn.com" "fra-a20.wlvpn.com" "fra-a21.wlvpn.com" "fra-a22.wlvpn.com" "fra-a23.wlvpn.com" "fra-a24.wlvpn.com" "fra-a25.wlvpn.com" "fra-a26.wlvpn.com" "zur-c01.wlvpn.com" "zur-c02.wlvpn.com" "tor-a01.wlvpn.com" "tor-a02.wlvpn.com" "tor-a03.wlvpn.com" "tor-a04.wlvpn.com" "tor-a05.wlvpn.com" "tor-a06.wlvpn.com" "tor-a07.wlvpn.com" "tor-a08.wlvpn.com" "tor-a09.wlvpn.com" "tor-a10.wlvpn.com" "gru-a01.wlvpn.com" "gru-a02.wlvpn.com" "bru-b01.wlvpn.com" "syd-a01.wlvpn.com" "syd-a02.wlvpn.com" "syd-a03.wlvpn.com" "syd-a04.wlvpn.com" "syd-a05.wlvpn.com" "syd-a06.wlvpn.com" "syd-a07.wlvpn.com" "syd-a08.wlvpn.com" "syd-a09.wlvpn.com" "syd-a10.wlvpn.com" "syd-a11.wlvpn.com" "syd-a12.wlvpn.com" "syd-a13.wlvpn.com" "syd-a14.wlvpn.com" "syd-a15.wlvpn.com" "syd-a16.wlvpn.com" "syd-a17.wlvpn.com" "syd-a18.wlvpn.com" "syd-a19.wlvpn.com" "syd-a20.wlvpn.com" "syd-a21.wlvpn.com" "syd-a22.wlvpn.com" "syd-a23.wlvpn.com" "syd-a24.wlvpn.com" "syd-a25.wlvpn.com" "syd-a26.wlvpn.com" "syd-a27.wlvpn.com" "syd-a28.wlvpn.com" "syd-a29.wlvpn.com" "vie-c01.wlvpn.com" "vie-c02.wlvpn.com" "vie-c03.wlvpn.com" )

for server in "${servers[@]}";
  do
    IFS='.' read -ra URL <<< "$server"
    export PROVIDER_SERVER=${server};
    envsubst < "newshosting_vpn.tmpl" > "$provider/${URL[0]}.ovpn";
  done

export PROVIDER_SERVER="ams-a20.wlvpn.com";
envsubst < "newshosting_vpn.tmpl" > "$provider/default.ovpn";

echo "Created all .ovpn files in folder $provider"
