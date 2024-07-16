#!/usr/bin/env python3
"""Script to insert a new document into a collection"""

def insert_school(mongo_collection, **kwargs):
    """Function to handle the insertion and return the id"""

    result = mongo_collection.insert_one(kwargs)
    return result.inserted_id
