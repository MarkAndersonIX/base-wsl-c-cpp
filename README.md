# Pybind11 Python Build Base
Some boilerplate for working with C/C++ bindings for Python in Windows using WSL.

## Environment
1. Install WSL
2. apt install build-essentials gdb
3. Install C/C++ extension in VSCode
4. Install Python extension in VSCode
5. Install Anaconda
6. Create conda env "pybind11":
  `conda env create -n pybind11 pybind11`

### Update c_cpp_properties.json
You can find the includes for pybind using the follow command if you need to reference them:
```
python -m pybind11 --includes
```
Specifically the site-packages path.
This can be added to c_cpp_properties.json to resolve the include lint:

```
...
              "includePath": [
                  "${workspaceFolder}/**",
                  "${workspaceFolder}/include",
                  "/some/path/to/site-packages/pybind11/include"
              ]
...
```

### Create setup.py
Assuming we have a c++ project with source file HelloWorld.cpp and headers in include/, we create a setup.py which will gather modules and define a setup for building bindings with pybind11.

##### Extension Module Definition (ext_modules):
1.  Defines an extension module (Extension) named 'helloworld'.
2.  Specifies the source file ('src/HelloWorld.cpp') containing the C++ code to be compiled.

##### Includes directories (include_dirs):
pybind11_include: Directory containing pybind11 headers.
'include': Additional include directories for any other headers needed by the C++ code.
Specifies the language as 'c++' for C++ compilation.

##### Setup Configuration (setup()):
- name='helloworld': Name of the Python package/module.
- version='0.1': Version number of the package/module.
- ext_modules=ext_modules: List of extension modules to be built, defined earlier.
- cmdclass={'build_ext': build_ext}: Specifies the command class to use (build_ext) handling the build process of extension modules.
- script_args=['build_ext', '--build-lib', 'build/']: Additional script arguments for the setup process:
  - 'build_ext': Command to build extension modules.
  - '--build-lib', 'build/': Specifies the build directory ('build/') where the compiled extension module will be placed.

### main.py
Import the compiled bindings and test output.
```
from build import helloworld

hello = helloworld.HelloWorld("World")
hello.sayHello()  # Output: Hello, World!
```

### tasks.json
```
      {
        "label": "build-pybind11",
        "type": "shell",
        "command": "python",
        "args": ["setup.py","build_ext","--inplace"],
        "group": {
            "kind": "build",
            "isDefault": true
        },
        "problemMatcher": [],
        "detail": "Builds project python bindings using python and pybind11"
      },
```
Given that we've added our wsl conda environment as the python interpreter (Ctl+Shift+P -> "Python Interpreter"), we should be able to call this and have setup.py build python bindings for our c++ project.

```
 *  Executing task: python setup.py build_ext --inplace 

running build_ext
building 'helloworld' extension
creating build
creating build/temp.linux-x86_64-cpython-312
creating build/temp.linux-x86_64-cpython-312/src
gcc -pthread -B /home/user/anaconda3/envs/pybind11/compiler_compat -fno-strict-overflow -DNDEBUG -O2 -Wall -fPIC -O2 -isystem /home/user/anaconda3/envs/pybind11/include -fPIC -O2 -isystem /home/user/anaconda3/envs/pybind11/include -fPIC -I/home/user/anaconda3/envs/pybind11/lib/python3.12/site-packages/pybind11/include -Iinclude -I/home/user/anaconda3/envs/pybind11/include/python3.12 -c src/HelloWorld.cpp -o build/temp.linux-x86_64-cpython-312/src/HelloWorld.o
g++ -pthread -B /home/user/anaconda3/envs/pybind11/compiler_compat -shared -Wl,-rpath,/home/user/anaconda3/envs/pybind11/lib -Wl,-rpath-link,/home/user/anaconda3/envs/pybind11/lib -L/home/user/anaconda3/envs/pybind11/lib -Wl,-rpath,/home/user/anaconda3/envs/pybind11/lib -Wl,-rpath-link,/home/user/anaconda3/envs/pybind11/lib -L/home/user/anaconda3/envs/pybind11/lib build/temp.linux-x86_64-cpython-312/src/HelloWorld.o -o build/helloworld.cpython-312-x86_64-linux-gnu.so
 *  Terminal will be reused by tasks, press any key to close it. 

 *  Executing task: python main.py 

Hello World, from pybind11!

 *  Terminal will be reused by tasks, press any key to close it.
 ```