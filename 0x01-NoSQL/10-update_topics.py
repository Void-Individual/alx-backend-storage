#!/usr/bin/env python3
"""Module to change topics of a document"""


def update_topics(mongo_collection, name, topics):
    """Function to change all the topics of a school document
    based on the name"""

    try:
        # Update operation using UpdateOne
        update_result = mongo_collection.update_many(
            {"name": name},
            {"$set": {"topics": topics}}
        )

        # Check if the update was successful
        if update_result.modified_count > 0:
            return True
        else:
            return False

    except Exception as e:
        print(f"Error occurred: {e}")
        return False
