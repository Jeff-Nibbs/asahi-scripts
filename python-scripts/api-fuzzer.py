#!/usr/bin/env python3

import requests
import sys

for word in sys.stdin:
    fix_word = word.strip()
    res = requests.get(url=f"https://catfact.ninja/{fix_word}")
    if res.status_code == 200:
        print(f"{fix_word}")
        print(res)


