#!/usr/bin/env python3
"""Module to return sorted students"""


def top_students(mongo_collection):
    """Function to sort the students by average score"""

    score_of_students = []
    for student in mongo_collection.find():
        averageScore = 0
        topics = student.get('topics', [])
        total_score = sum(topic.get('score', 0) for topic in topics)
        count  = len(topics)
        if count > 0:
            averageScore = total_score / count

        # Update the student document
        mongo_collection.update_one(
            {"name": student.get('name')},
            {"$set": {"averageScore": averageScore}}
        )

        student['averageScore'] = averageScore
        score_of_students.append(student)
    sorted_students = sorted(score_of_students, key=lambda x: x['averageScore'], reverse=True)
    return sorted_students
