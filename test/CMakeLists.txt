# ---- Set name for test executable ----

set(TEST_EXEC test_${PROJECT_NAME})

# ---- Test dependencies ----

CPMAddPackage(
  NAME cctest
  GITHUB_REPOSITORY ccup/cctest
  GIT_TAG master
)

# ---- Add color log for test ----

set (log_output_func_declare "void mcl_color_log(int level , const char* levelstr , const char* file, unsigned int line, const char* fmt, ...)")
set (log_output_func "mcl_color_log")
set (log_enabled_levels "MCL_TOTAL_LEVEL")

configure_file (
    "${CMAKE_HOME_DIRECTORY}/deps/mcl/log_customized_config.h.in"
    "${CMAKE_HOME_DIRECTORY}/deps/mcl/log_customized_config.h"
)

# ---- Source files of test ----

file(GLOB_RECURSE SOURCES
*.cpp
*.cc
*.c++
*.c
*.C)

# ---- Import system link path ----

link_directories("/usr/local/lib")

# ---- Define test target ----

add_executable(${TEST_EXEC} ${SOURCES})

target_include_directories(${TEST_EXEC} 
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} 
            ${PROJECT_SOURCE_DIR}/deps
            ${PROJECT_SOURCE_DIR}/src
            "/usr/local/include")

target_link_libraries(${TEST_EXEC} PRIVATE ${PROJECT_NAME} cctest_main)

set_target_properties(${TEST_EXEC} PROPERTIES CXX_STANDARD 14)
target_compile_definitions(${TEST_EXEC} PRIVATE CUSTOMER_LOG)

# ---- Code coverage ----

if(ENABLE_TEST_COVERAGE)
  target_compile_options(${TEST_EXEC} PUBLIC -O0 -g -fprofile-arcs -ftest-coverage)
  target_link_options(${TEST_EXEC} PUBLIC -fprofile-arcs -ftest-coverage)
endif()

# ---- Add test for CTest ----

add_test(NAME test COMMAND ${TEST_EXEC})
