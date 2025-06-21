#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup

wiki = "wiki"
url_add = "https://en.wikipedia.org"

def get_page(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    a_tags = soup.find_all("a", href=True)
    for i in a_tags:
        link = i.get("href")
        if wiki in link:
            if "https" not in link and "en." not in link:
                link = url_add + link
            print(link)

get_page(input("Website: "))
