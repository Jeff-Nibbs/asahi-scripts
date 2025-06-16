#!/usr/bin/env bash

echo " "
echo "IP: $( ip a | grep 'wlp1s0f0' | cut -d ' ' -f 6 | tr -d 'qdisc' | tr -d '\n')"
