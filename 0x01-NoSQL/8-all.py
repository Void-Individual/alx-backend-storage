#!/usr/bin/env python3
"""Script to list all the documents in a collection"""


def list_all(mongo_collection):
    """Function to list all the documents in a collection"""

    documents = []
    for doc in mongo_collection.find():
        documents.append(doc)

    return documents
