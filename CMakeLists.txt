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