#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup as BS
from urllib.parse import urljoin


visited_urls = set()

def spider_urls(url, keyword, depth=0, max_depth=10):
    if depth > max_depth:
        return  # Prevent infinite recursion

    try:
        response = requests.get(url=url, timeout=5)
        response.raise_for_status()
    except requests.RequestException:
        return  # Skip URLs that fail
    except:
        print(f"Request Failed {url}")

    else:
        if response.status_code == 200:
            soup = BS(response.content, "html.parser")
            a_tags = soup.find_all("a", href=True) if soup else []
            urls = []

        for tag in a_tags:
            href = tag.get("href")
            if href is not None:
                urls.append(href)
        for a in urls:
            if a not in visited_urls:
                visited_urls.add(a)
                url_join = urljoin(url, a)
                if keyword in url_join:
                    print(url_join)
                    spider_urls(url_join, keyword, depth + 1, max_depth)
                else:
                    return

target_url = input("URL: ")
target_keyword = input("Keyword: ")
spider_urls(target_url, target_keyword)
