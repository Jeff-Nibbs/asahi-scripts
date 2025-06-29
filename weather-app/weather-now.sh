#!/usr/bin/env bash

folder_path="/home/mrmans/asahi-scripts/weather-app"

format_date () {
  echo "$( date -d @$1 '+| %a %b %d ~ %I:%M %p |' )"  
}

format_time () {
  echo "$( date -d @$1 '+%I:%M %p' )"
}

my_lat="38.807930"
my_lon="-121.273643"

store_lat="38.788261"
store_lon="-121.206551"

quote=$( curl -s "https://api.adviceslip.com/advice" | jq ".slip.advice" )

kanye_quote=$( curl -s "https://api.kanye.rest" | jq ".quote" )

curl -s "https://api.openweathermap.org/data/2.5/weather?lat=$my_lat&lon=$my_lon&appid=$WEATHER_KEY&units=imperial" > $folder_path/cahe_my_weather.txt

curl -s "https://api.openweathermap.org/data/2.5/weather?lat=$store_lat&lon=$store_lon&appid=$WEATHER_KEY&units=imperial" > $folder_path/cahe_store_weather.txt

my_current_temp=$( cat $folder_path/cahe_my_weather.txt | jq ".main.temp" )

my_current_desc=$( cat $folder_path/cahe_my_weather.txt | jq ".weather.[0].description" | tr -d '"' )

my_current_desc=$( cat $folder_path/cahe_my_weather.txt | jq ".weather.[0].description" | tr -d '"' )

store_current_temp=$( cat $folder_path/cahe_store_weather.txt | jq ".main.temp" )

store_current_desc=$( cat $folder_path/cahe_store_weather.txt | jq ".weather.[0].description" | tr -d '"' )

time=$( cat $folder_path/cahe_store_weather.txt | jq ".dt" )

my_feels_like=$( cat $folder_path/cahe_my_weather.txt | jq ".main.feels_like" )

store_feels_like=$( cat $folder_path/cahe_store_weather.txt | jq ".main.feels_like" )

sunrise=$( cat $folder_path/cahe_my_weather.txt | jq ".sys.sunrise" )

sunset=$( cat $folder_path/cahe_my_weather.txt | jq ".sys.sunset" )

fahrenheit="°F"
am="AM"
pm="PM"

figlet -c -f 'ANSI Shadow' -t WEATHER
echo " "
echo "              $( format_date $time )"
echo " "
echo "                         Home"
echo "                   Temp: ${my_current_temp}${fahrenheit}"
echo "             Feels Like: ${my_feels_like}${fahrenheit}"
echo "                  $my_current_desc outside"
echo " "
echo "                         Work"
echo "                   Temp: ${store_current_temp}${fahrenheit}"
echo "             Feels Like: ${store_feels_like}${fahrenheit}"
echo "                  $store_current_desc outside"
echo " "
echo "                Sunrise: $( format_time $sunrise )"
echo "                 Sunset: $( format_time $sunset )"
echo " "
echo "                  Quote: $quote"
echo " "
echo " "
echo "            Kanye Quote: $kanye_quote"
echo " "


