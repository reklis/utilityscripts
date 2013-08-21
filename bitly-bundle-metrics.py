#!/usr/bin/env python

import requests
import os
import sys
import time

bitly_username = str(os.getenv("bitly_username"))
bitly_password = str(os.getenv("bitly_password"))
bitly_host = "https://api-ssl.bitly.com"


def url(path):
    return bitly_host + path


def get_token():
    return requests.post(url("/oauth/access_token"),
        auth=(bitly_username, bitly_password)).text


def get_bundle_info(access_token, bundle_link):
    bundle_info = requests.get(url("/v3/bundle/contents"),
        params={
            "access_token": access_token,
            "bundle_link": bundle_link
        }).json()

    if bundle_info["status_code"] != 200:
        print bundle_info
        sys.exit(-1)
    else:
        return bundle_info["data"]


def get_link_clicks(now, access_token, link_shorturl, unit):
    link_clicks = requests.get(url("/v3/link/clicks"),
        params={
            "access_token": access_token,
            "link": link_shorturl,
            "unit": unit,
            "units": 1,
            "unit_reference_ts": now
        }).json()

    if link_clicks["status_code"] != 200:
        print link_clicks
        sys.exit(-2)
    else:
        # print link_shorturl
        # print unit
        # print link_clicks
        return link_clicks["data"]


def main():
    bundle_link = sys.argv[1]
    now = int(time.time())

    access_token = get_token()
    bundle_info = get_bundle_info(access_token, bundle_link)

    print "link\tmonth\tweek\tday"

    for link_info in bundle_info["bundle"]["links"]:
        link_shorturl = link_info["link"]
        link_title = link_info["title"]

        link_month = get_link_clicks(now, access_token, link_shorturl, "month")
        link_week = get_link_clicks(now, access_token, link_shorturl, "week")
        link_day = get_link_clicks(now, access_token, link_shorturl, "day")

        print "%s\t%s\t%s\t%s\t%s" % (
            link_title,
            link_shorturl,
            str(link_month["link_clicks"]),
            str(link_week["link_clicks"]),
            str(link_day["link_clicks"])
        )

if __name__ == '__main__':
    main()
