# ---- Collect all src files except main.c ----

file(GLOB_RECURSE MAIN_FILE 
  "main.c"
)

file(GLOB_RECURSE SOURCES
  "*.c" "*.C" "*.cc" "*.CC" "*.cpp" "*.CPP"
)

list(REMOVE_ITEM SOURCES ${MAIN_FILE})

# ---- Define library target ----

if (SHARED)
  set(LIB_TYPE SHARED)
  set(CMAKE_C_VISIBILITY_PRESET hidden)
else()
  set(LIB_TYPE STATIC)
endif()

add_library(${PROJECT_NAME} ${LIB_TYPE} ${SOURCES})

target_include_directories(${PROJECT_NAME} 
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/deps
    PUBLIC ${PROJECT_SOURCE_DIR}/include
)

# ---- Add main target ----

if (EXECUTABLE AND NOT ENABLE_TEST)
  set(SERVICE_EXEC ${PROJECT_NAME}_service)
  add_executable(${SERVICE_EXEC} ${MAIN_FILE})
  target_link_libraries(${SERVICE_EXEC} PRIVATE ${PROJECT_NAME})
endif()