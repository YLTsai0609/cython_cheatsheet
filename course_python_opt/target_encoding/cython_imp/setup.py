from distutils.core import Extension, setup

import numpy
from Cython.Build import cythonize

# compile_flags = ['-std=c++11',  '-fopenmp']
# linker_flags = ['-fopenmp']

# compile_flags = ["-std=c++11"]

# module = Extension(
#     "tm",
#     ["tm.pyx"],
#     language="c++",
#     include_dirs=[numpy.get_include()],  # This helps to create numpy
#     extra_compile_args=compile_flags,
#     #    extra_link_args=linker_flags
# )

# setup(
#     name="tm",
#     ext_modules=cythonize(module),
# )


compile_flags = ["-std=c++11"]

module = Extension(
    "target_encoding_cython",
    ["target_encoding_cython.pyx"],
    language="c++",
    include_dirs=[numpy.get_include()],  # This helps to create numpy
    extra_compile_args=compile_flags,
    #    extra_link_args=linker_flags
)

setup(
    name="target_encoding_cython",
    ext_modules=cythonize(module),
)
