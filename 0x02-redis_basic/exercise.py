#!/usr/bin/env python3
"""Redis module"""

import uuid
import redis
from typing import Union, Callable, Optional
from functools import wraps


def count_calls(method: Callable) -> Callable:
    """Decorator function that takes a method callable as an
    argument and returns a callable"""

    @wraps(method)
    def count_wrapper(self, *args, **kwargs):
        """Function to make this method a key and increment its value
        in the redis instance"""

        self._redis.incr(method.__qualname__)
        return method(self, *args, **kwargs)

    return count_wrapper


def call_history(method: Callable) -> Callable:
    """Decorator function to keep track of input and output values by
    storing them in different lists"""

    @wraps(method)
    def list_method(self, *args, **kwargs):
        """Function to add parameters to redis lists"""
        self._redis.rpush(f"{method.__qualname__}:inputs", str(args))
        data = method(self, *args, **kwargs)
        self._redis.rpush(f"{method.__qualname__}:outputs", data)
        return data

    return list_method


def replay(method: Callable) -> None:
    """Function to display the history of calls of a method"""

    # Retrieve the redis instance from the cache class
    cache = method.__self__
    # Retrieve the method name
    name = method.__qualname__
    # Retrieve the number of times the method was called
    count = cache._redis.get(method.__qualname__)
    print(f"{name} was called {int(count)} times:")

    # Retrieve the input values stored
    input_list = cache._redis.lrange(f"{name}:inputs", 0, -1)
    # Retrieve the output values stored
    output_list = cache._redis.lrange(f"{name}:outputs", 0, -1)
    # Pair up the values using zip, and affix it as a dict
    paired = dict(zip(input_list, output_list))
    # Decode each of the previously stored values before printing them
    for key, value in paired.items():
        print(f"{name}(*{key.decode('utf-8')}) -> {value.decode('utf-8')}")


class Cache:
    """A cache class to hold an instance of a redis client"""

    def __init__(self) -> None:
        """Init this instance of the class to create a new instance
        and flush the current database"""

        self._redis = redis.Redis(host='localhost', port=6379)
        self._redis.flushdb()

    @count_calls
    @call_history
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
