'''
寫Cython, Numba的實際做法還是蠻像的

1. 把numpy的特殊函數變成for loop, += 的形式 (v3 -> v2)
2. 翻譯成 numba or cython (無腦抄)
3. 也還能優化，但效益可能不高了

效能上從 target_v1 13秒 -> target_v3 0.0016 : 8000倍
'''
# distutils: language=c++
import numpy as np
cimport numpy as np

# hello for compiling test purpose

def hello():
    print("hello")

# data for feature matrix (nrows, nfeatures)
# python def function for compare correctness

def target_mean_v2(data, y_name, x_name):
    result = np.zeros(data.shape[0])
    value_dict = dict()
    count_dict = dict()
    
    for i in range(data.shape[0]):
        if data.loc[i, x_name] not in value_dict.keys():
            value_dict[data.loc[i, x_name]] = data.loc[i, y_name]
            count_dict[data.loc[i, x_name]] = 1
        else:
            value_dict[data.loc[i, x_name]] += data.loc[i, y_name]
            count_dict[data.loc[i, x_name]] += 1
    
    for i in range(data.shape[0]):
        result[i] = (
            ( value_dict[data.loc[i, x_name]] - data.loc[i, y_name] ) / 
            ( count_dict[data.loc[i, x_name]] - 1 )
        )
    return result

# cpdef , data, y_name, x_name 仍然可以使用python object
# np.asfortranarray - 

# declare result first

cpdef target_mean_v3(data, y_name, x_name):
    cdef long nrow = data.shape[0]
    cdef np.ndarray[double] result = np.asfortranarray(np.zeros(nrow), dtype=np.float64)
    cdef np.ndarray[double] y = np.asfortranarray(data[y_name], dtype=np.float64)
    cdef np.ndarray[double] x = np.asfortranarray(data[x_name], dtype=np.float64)

    target_mean_v3_impl(result, y, x, nrow)
    return result

# implement the computation logic
# we still can use python object，還是可以，
# 1. 但是你可以call cython裡面類似的hash table
# 2. dict long -> int
# 3. range -> prange

cdef void target_mean_v3_impl(double[:] result, double[:] y, double[:] x, const long nrow):
    cdef dict value_dict = dict()
    cdef dict count_dict = dict()

    cdef long i
    for i in range(nrow):
        if x[i] not in value_dict.keys():
            value_dict[x[i]] = y[i]
            count_dict[x[i]] = 1
        else:
            value_dict[x[i]] += y[i]
            count_dict[x[i]] += 1

    i=0
    for i in range(nrow):
        result[i] = (value_dict[x[i]] - y[i])/(count_dict[x[i]]-1)
