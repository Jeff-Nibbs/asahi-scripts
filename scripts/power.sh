#!/usr/bin/env bash

home="/home/mrmans"
while getopts "gpwfb" flags; do
    case "$flags" in
        g) $home/asahi-scripts/scripts/start-day.sh;;
	p) $home/asahi-scripts/scripts/myip.sh;;
	w) $home/asahi-scripts/weather-app/weather-now.sh | boxes -p a3 -d ansi-double | lolcat -f -r;;
	f) $home/asahi-scripts/weather-app/forcast.sh | boxes -d ansi | lolcat -f -r;;
        b) $home/asahi-scripts/scripts/battery-health.sh ;;
    esac
done


