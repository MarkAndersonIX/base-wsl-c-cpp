# base-wsl-c-cpp
Some boilerplate for working with C/C++ projects in Windows using WSL.

1. Install WSL
2. apt install build-essentials gdb
3. Install C/C++ extension in VSCode
4. Create [tasks.json](.vscode/tasks.json)
    Ctl+Shift+P -> Configure Tasks
5. Create [launch.json](.vscode/launch.json)
    Ctl+Shift+P -> Debug: Add Configuration

Build:
Ctl+Shift+B

Debug:
select "(gdb) Launch" or F5

## Ninja
https://ninja-build.org/

apt-get install ninja-build

#### CMake
Ninja uses CMake

`apt-get install ninja-build`

#### CMakeLists.txt
Create or update CMakeLists.txt in the root directory of your project:

```
cmake_minimum_required(VERSION 3.22)
project(MyProject)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Define source and include directories
set(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")

# Gather source files
file(GLOB SOURCES
    "${SOURCE_DIR}/*.cpp"
)

# Add executable target
add_executable(main.out ${SOURCES})

# Include directories for the target
target_include_directories(main.out PRIVATE
    ${INCLUDE_DIR}
)
```

#### Explanation
cmake_minimum_required(VERSION 3.10): Specifies the minimum version of CMake required to build the project.

`project(MyProject)`: Defines the project name.

`set(CMAKE_CXX_STANDARD 11)`: Sets the C++ standard to C++11. Adjust this according to your project's requirements (C++14, C++17, etc.).

`set(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")`: Defines the source directory where the .cpp files are located. ${CMAKE_CURRENT_SOURCE_DIR} is a CMake variable representing the current source directory.

`set(INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")`: Defines the include directory where the .h or .hpp header files are located.

`file(GLOB SOURCES "${SOURCE_DIR}/*.cpp")`: Uses file(GLOB ...) to gather all .cpp files from the src directory into the SOURCES variable. This approach 
collects all .cpp files dynamically at configuration time.

`add_executable(main.out ${SOURCES})`: Creates an executable target named main.out using the source files specified in the SOURCES variable. This command tells CMake to compile all .cpp files listed in SOURCES into an executable named main.out.

`target_include_directories(main.out PRIVATE ${INCLUDE_DIR})`: Specifies the include directories (include/ in this case) for the main.out target. The PRIVATE keyword ensures that these directories are only applied to the main.out target and not propagated to other targets.

Summary
This CMakeLists.txt snippet sets up a CMake project named MyProject with:

C++ standard set to C++11 (set(CMAKE_CXX_STANDARD 11)).
Source files gathered from the src/ directory using file(GLOB ...).
An executable target (main.out) created from the gathered source files.
Include directories (include/) specified for the executable target (main.out).

### Ninja Build
From the CMakeLists.txt file we can generate Ninja build files.

1.  Generate Ninja Build Files:
`cmake -B build -GNinja`
2.  Build project:
`ninja -C build`

To add this to tasks.json we can add steps to generate cmake files as a dependency to the ninja compilation:
```
      {
        "label": "build-with-cmake",
        "type": "shell",
        "command": "cmake",
        "args": [
          "-B", "${workspaceFolder}/build", "-GNinja"
        ],
        "group": {
          "kind": "build",
          "isDefault": true
        },
        "problemMatcher": [],
        "detail": "Build project using make."
      },
      {
        "label": "build with ninja",
        "type": "shell",
        "command": "ninja",
        "args": ["-C", "build"],
        "group": {
            "kind": "build",
            "isDefault": true
        },
        "dependsOn": ["build-with-cmake"],
        "problemMatcher": ["$gcc"]
      },
```