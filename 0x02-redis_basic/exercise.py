#!/usr/bin/env python3
"""Redis module"""

import uuid
import redis
from typing import Union, Callable, Optional
from functools import wraps


def count_calls(method: Callable) -> Callable:
    """Takes a method callable argument and returns a callable"""

    @wraps(method)
    def count_wrapper(self, *args, **kwargs):
        """Function to make this method a key and increment its value
        in the redis instance"""

        self._redis.incr(method.__qualname__)
        return method(self, *args, **kwargs)

    return count_wrapper


class Cache:
    """A cache class to hold an instance of a redis client"""

    def __init__(self) -> None:
        """Init this instance of the class to create a new instance
        and flush the current database"""

        self._redis = redis.Redis(host='localhost', port=6379)
        self._redis.flushdb()

    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """Method to generate a random key, store it in redis and
        return the key"""

        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    @count_calls
    def get(self, key: uuid.UUID, fn: Optional[Callable] = None) -> str:
        """Get method to retrieve the value of the key in desired format"""

        value = self._redis.get(key)
        if fn:
            return fn(value)
        return value

    @count_calls
    def get_str(self, key: uuid.UUID) -> str:
        """Method to retrieve and return a str instead of binary"""

        data = self._redis.get(key)
        return str(data)

    @count_calls
    def get_int(self, key: uuid.UUID) -> int:
        """Method to retrieve and return an int instead of binary"""

        data = self._redis.get(key)
        return int(data)
