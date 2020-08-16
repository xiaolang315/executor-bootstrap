cmake_minimum_required(VERSION 3.4)

project(executor)

add_subdirectory("src")

if(ENABLE_TEST)
    add_subdirectory(test)
endif()