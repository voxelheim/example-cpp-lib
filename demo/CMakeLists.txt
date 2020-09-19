cmake_minimum_required(VERSION 3.15)

project(demo)

find_package(ExampleCppLib 1.0.0 REQUIRED)

add_executable(demo src/main.cpp)

target_link_libraries(demo ExampleCppLib::examplecpplib)