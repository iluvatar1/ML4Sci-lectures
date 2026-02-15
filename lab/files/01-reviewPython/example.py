# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "requests<3",
#   "beautifulsoup4",
# ]
# ///

import requests
from bs4 import BeautifulSoup

def fetch_and_parse(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    return soup.title.string

if __name__ == "__main__":
    url = "https://example.com"
    title = fetch_and_parse(url)
    print(f"The title of {url} is: {title}")
