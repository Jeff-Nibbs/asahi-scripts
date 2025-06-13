#!/usr/bin/env bash

folder_path="/home/mrmans/asahi-scripts/weather-app"

my_lat="38.807930"
my_lon="-121.273643"

store_lat="38.788261"
store_lon="-121.206551"

nesw() {
  local maths=$(( ( $1 / 90 ) % 4 ))
  echo "$maths"
}

find_heading() {
  if [[ $1 == 0 ]]; then
    echo "North"
  elif [[ $1 == 1 ]]; then
    echo "East"
  elif [[ $1 == 2 ]]; then
    echo "South"
  elif [[ $1 == 3 ]]; then
    echo "West"
  else
    echo "The code is broken"
  fi
}

curl -s "https://api.openweathermap.org/data/2.5/forecast?lat=$my_lat&lon=$my_lon&appid=$WEATHER_KEY&units=imperial" > $folder_path/cahe_forcast.txt

for i in {39..0};
do
  time=$( cat $folder_path/cahe_forcast.txt | jq ".list.[$i | tonumber].dt" )
 
  temp=$( cat $folder_path/cahe_forcast.txt | jq ".list.[$i | tonumber].main.temp" )
  
  desc=$( cat $folder_path/cahe_forcast.txt | jq ".list.[$i | tonumber].weather.[0].description" )
  
  windSpeed=$( cat $folder_path/cahe_forcast.txt | jq ".list.[$i | tonumber].wind.speed" )
 
  windDirection=$( cat $folder_path/cahe_forcast.txt | jq ".list.[$i | tonumber].wind.deg" )
  
  feels_like=$( cat $folder_path/cahe_forcast.txt | jq ".list.[$i | tonumber].main.feels_like" ) 
  
  wd=$(nesw $windDirection)
  direction=$(find_heading $wd)

  temp_imperial="°F"
  wind_imperial="mph"

  echo " "
  echo "$( date -d @$time "+| %a %b %d ~ %I:%M %p |" )"
  echo " "
  echo "       Temp: ${temp}${temp_imperial}"
  echo " Feels Like: ${feels_like}${temp_imperial}"
  echo " Wind Speed: ${windSpeed}${wind_imperial} ${direction}"
  echo "      $desc"
  echo " "
done






