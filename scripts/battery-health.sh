#!/usr/bin/env bash

LOGFILE="$HOME/asahi-scripts/text-files/battery_health_log.csv"

bold=$(tput bold)
reset=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

BATTERY_PATH=$(upower -e | grep battery)
if [[ -z "$BATTERY_PATH" ]]; then
  echo "❌ No battery found."
  exit 1
fi

DATA=$(upower -i "$BATTERY_PATH")

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
PERCENTAGE=$(echo "$DATA" | grep 'percentage' | awk '{print $2}' | tr -d '%')
CAPACITY=$(echo "$DATA" | grep 'capacity' | awk '{print $2}' | tr -d '%')
STATE=$(echo "$DATA" | grep 'state' | awk '{print $2}')
ENERGY_FULL=$(echo "$DATA" | grep 'energy-full:' | awk '{print $2}')
ENERGY_DESIGN=$(echo "$DATA" | grep 'energy-full-design:' | awk '{print $2}')

if [[ -n "$ENERGY_FULL" && -n "$ENERGY_DESIGN" ]]; then
    WEAR_LEVEL=$(awk "BEGIN { printf \"%.1f\", 100 - ($ENERGY_FULL / $ENERGY_DESIGN * 100) }")
else
    WEAR_LEVEL="N/A"
fi

if [ ! -f "$LOGFILE" ]; then
    echo "Timestamp,Percentage,Capacity,State,Wear_Level%" >> "$LOGFILE"
fi

echo "$TIMESTAMP,$PERCENTAGE,$CAPACITY,$STATE,$WEAR_LEVEL" >> "$LOGFILE"

case $STATE in
  discharging) STATE_COLOR=$yellow ;;
  charging) STATE_COLOR=$green ;;
  fully-charged) STATE_COLOR=$blue ;;
  *) STATE_COLOR=$white ;;
esac

LABEL_WIDTH=20
VALUE_WIDTH=30
INNER_WIDTH=$((LABEL_WIDTH + VALUE_WIDTH + 3))
TOTAL_WIDTH=$((INNER_WIDTH + 2))

horizontal_line() {
  printf "$1"
  printf '─%.0s' $(seq 1 "$2")
  printf "$3\n"
}

print_row() {
  local label="$1"
  local value="$2"
  local color="${3:-$white}"
  printf "│ %-*s ${color}%-*s${reset} │\n" "$LABEL_WIDTH" "$label" "$VALUE_WIDTH" "$value"
}

echo
horizontal_line "╭" "$INNER_WIDTH" "╮"
printf "│${bold}%-*s${reset}│\n" "$INNER_WIDTH" " Battery Health Status "
horizontal_line "├" "$INNER_WIDTH" "┤"

print_row "Timestamp" "$TIMESTAMP"
print_row "Battery Level" "$PERCENTAGE%" "$green"
print_row "Health Capacity" "$CAPACITY%" "$blue"
print_row "Charging State" "$STATE" "$STATE_COLOR"
print_row "Wear Level" "$WEAR_LEVEL% wear" "$red"

horizontal_line "╰" "$INNER_WIDTH" "╯"
echo
