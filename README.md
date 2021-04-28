# Ref

高效能Python 第七章 - 編譯成C

[【工程師實用外掛】開啟 Cython，讓你的 Python 運算速度提升 36 倍！](https://buzzorange.com/techorange/2019/08/05/cython-raise-speed-of-python/)

[Cython documentation](https://cython.readthedocs.io/en/latest/src/tutorial/cython_tutorial.html#the-basics-of-cython)


local path : `/Users/YuLong/Desktop/Working_Area/ml-training-camp/chap02/target_encoding/cython_imp`

# SOP

1. make sure the slow part of your code is computational bound(not IO bound)
2. unrolling the logic into for loop(e.g.`np.sum`, `DataFrame.groupby`)
3. using `Cython`, `Numba` to write a new func for your computational heavy function.
4. For `Cython`, python `setup.py` install for compile your `pyx` file.

# Best Practice

1. Write hello in `pyx` to check your complier(and compiling settings) works fine.
2. Write the unrolling logic in python, in order to check the correctness, then move the logic to `Cython`, `Numba`
3. First Optimization will give you a big gap on performance, then the speed you will gain become less.


