cmake_minimum_required(VERSION 3.14)

# ---- Project ----

project(executor)

# ---- Include guards ----

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there."
  )
endif()

# ---- Options for project ----

option(SHARED      "Generate shared library otherwise static" ON)
option(EXECUTABLE  "Generate executable target" OFF)
option(ENABLE_TEST "Build tests" OFF)
option(ENABLE_TEST_COVERAGE "Enable test coverage" OFF)

# ---- Using CPM to add dependencies for project ----

include(${PROJECT_SOURCE_DIR}/cmake/CPM.cmake)

# ---- Add source folder for project ----

add_subdirectory("src")

# ---- Add test for project ----

if(ENABLE_TEST)
  include(CTest)
  enable_testing()
  add_subdirectory(test)
endif()
