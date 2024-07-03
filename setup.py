from setuptools import setup, Extension
from distutils.command.build_ext import build_ext
import pybind11

# Get the include path for PyBind11
pybind11_include = pybind11.get_include()

ext_modules = [
    Extension(
        'helloworld',
        ['src/HelloWorld.cpp'],
        include_dirs=[pybind11_include, 'include'],
        language='c++'
    ),
]

setup(
    name='helloworld',
    version='0.1',
    ext_modules=ext_modules,
    cmdclass={'build_ext': build_ext},
    script_args=['build_ext', '--build-lib', 'build/']  # Specify build directory
)