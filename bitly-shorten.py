#!/usr/bin/env python

import requests
import os
import sys

bitly_username = str(os.getenv("bitly_username"))
bitly_password = str(os.getenv("bitly_password"))
bitly_host = "https://api-ssl.bitly.com"


def url(path):
    return bitly_host + path


def get_token():
    return requests.post(url("/oauth/access_token"),
        auth=(bitly_username, bitly_password)).text

def shorten(access_token, longUrl):
    cmd_url = url("/v3/shorten")
    # print cmd_url

    return requests.get(cmd_url,
        params={
            "access_token": access_token,
            "longUrl": longUrl
        }).json()

def main():
    urls = sys.argv
    urls.pop(0)

    access_token = get_token()

    for long_url in urls:
        short_url = shorten(access_token, long_url)
        print long_url + ',' + short_url['data']['url']


if __name__ == '__main__':
  main()