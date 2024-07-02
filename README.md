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

## Current Branches:
1. cpp-gpp: C++ using G++ build.
2. cpp-make: C++ using GNU Make.
3. cpp-ninja: C++ using CMake + Ninja build.