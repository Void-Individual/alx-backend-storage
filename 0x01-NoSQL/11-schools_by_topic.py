#!/usr/bin/python3
"""Module to return the list of schools having a specific topic"""


def schools_by_topic(mongo_collection, topic):
    """Function to return the list of all documents with matching topics"""

    documents =[]
    for document in mongo_collection.find({"topics": topic}):
        documents.append(document)

    return documents
