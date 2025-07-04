#!/usr/bin/env bash

start="asahi-scripts/text-files"

fox() {
    firefox $(cat "$HOME/$start/$1" &)
}

while getopts 'pgd' flags; do
    case "${flags}" in
        d) fox "daily-websites.txt";;
        p) fox "practice-websites.txt";;
        g) firefox https://google.com;;
     esac
done
