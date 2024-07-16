#!/usr/bin/env python3
"""Module to retrieve stats about nginx logs"""

from pymongo import MongoClient


if __name__ == "__main__":
    client = MongoClient('mongodb://127.0.0.1:27017')
    data = client.logs.nginx

    methods = {"GET": 0, "POST": 0, "PUT": 0, "PATCH": 0, "DELETE": 0}
    count = 0
    for x in data.find():
        count += 1
    print(f"{count} logs")
    print("Methods:")

    status_count = 0
    for res in data.find():
        if res['method'] in methods:
            if res['method'] == "GET" and res['path'] == "/status":
                status_count +=1
            methods[res['method']] += 1

    for key, value in methods.items():
        print(f"\tmethod {key}: {value}")

    print(f"{status_count} status check")
