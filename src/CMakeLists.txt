# ---- Src dependencies ----

CPMAddPackage(
  NAME mcl
  GITHUB_REPOSITORY ccup/mcl
  GIT_TAG master
)

# ---- Collect all src files except main.c ----

file(GLOB_RECURSE MAIN_FILE 
  "main.c"
)

file(GLOB_RECURSE SOURCES
  "*.c" "*.C" "*.cc" "*.CC" "*.cpp" "*.CPP" "*.c++"
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

target_link_libraries(${PROJECT_NAME} PUBLIC mcl)

target_include_directories(${PROJECT_NAME}
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/deps
    PUBLIC ${PROJECT_SOURCE_DIR}/include
)

# ---- Add executable target ----

if (EXECUTABLE AND NOT ENABLE_TEST)
  set(EXEC_TARGET ${PROJECT_NAME}_service)
  add_executable(${EXEC_TARGET} ${MAIN_FILE})
  target_link_libraries(${EXEC_TARGET} PRIVATE ${PROJECT_NAME})
endif()