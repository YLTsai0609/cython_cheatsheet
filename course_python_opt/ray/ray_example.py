"""
https://github.com/ray-project/ray
If you only wanna read, without write
Introduction
https://towardsdatascience.com/10x-faster-parallel-python-without-python-multiprocessing-e5017c93cce1
"""
import time

# coding = 'utf-8
import numpy as np

import ray


@ray.remote
def f(x):
    return x * x


def demo():
    futures = [f.remote(i) for i in range(4)]
    print(ray.get(futures))  # [0, 1, 4, 9]


@ray.remote
def print_shape(x):
    return x.shape[0]


def print_parallel_v1(matrix):
    futures = [print_shape.remote(matrix) for _ in range(20)]
    print(ray.get(futures))


if __name__ == "__main__":
    ray.init()
    matrix = np.random.randn(10000000, 10)
    matrix_id = ray.put(matrix)
    start = time.time()
    print_parallel_v1(matrix_id)
    end = time.time()
    print(end - start)
