#!/usr/bin/env python3

import requests
import sys

for word in sys.stdin:
    res = requests.get(url=f"https://catfact.ninja/{word}")
    print(f"https://catfact.ninja/{word}")
    print(word)
    print(res)
    print(res.json())



