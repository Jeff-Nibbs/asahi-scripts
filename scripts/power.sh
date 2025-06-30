#!/usr/bin/env bash

home="/home/mrmans"
while getopts "gpwf" flags; do
    case "$flags" in
        g) $home/asahi-scripts/scripts/start-day.sh;;
	p) $home/asahi-scripts/scripts/myip.sh;;
	w) $home/asahi-scripts/weather-app/weather-now.sh;;
	f) $home/asahi-scripts/weather-app/forcast.sh;;
    esac
done


