set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-invalid-offsetof -g -std=gnu++11")

set (log_output_func_declare "void mcl_color_log(int level , const char* levelstr , const char* file, unsigned int line, const char* fmt, ...)")
set (log_output_func "mcl_color_log")
set (log_enabled_levels "MCL_TOTAL_LEVEL")

configure_file (
    "${CMAKE_HOME_DIRECTORY}/deps/mcl/log_customized_config.h.in"
    "${CMAKE_HOME_DIRECTORY}/deps/mcl/log_customized_config.h"
)

file(GLOB_RECURSE SOURCES
*.cpp
*.cc
*.c++
*.c
*.C)

link_directories("/usr/local/lib")

add_executable(test_executor ${SOURCES})

target_include_directories(test_executor 
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} 
            ${PROJECT_SOURCE_DIR}/deps
            "/usr/local/include")

target_link_libraries(test_executor PRIVATE executor cctest cctest_main)

target_compile_definitions(test_executor PRIVATE CUSTOMER_LOG)
