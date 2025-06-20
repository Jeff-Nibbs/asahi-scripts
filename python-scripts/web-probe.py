#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup

def get_page(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    a_tags = soup.find_all("a")
    for i in a_tags:
        link = i.get("href")
        print(link)

get_page(input("Website: "))
