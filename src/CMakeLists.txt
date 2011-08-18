# Include the directory itself as a path to include directories
#set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(QUASAR_SOURCES main.c fetch.c parse.c quasar.c)

add_definitions(-ggdb3 -Wall -Wextra -std=c99 -pedantic ${CURL_DEFINITIONS} ${LibXml2_DEFINITIONS})
include_directories(${LIBXML2_INCLUDE_DIR} ${CURL_INCLUDE_DIR})

add_executable(quasar ${QUASAR_SOURCES})
target_link_libraries(quasar ${CURL_LIBRARY} ${LIBXML2_LIBRARIES})

# For a large number of source files you can create it in a simpler way
# using file() function:
# file(GLOB hellworld_SOURCES *.cpp)
# Make sure the compiler can find include files from our Hello library.
# include_directories (${HELLO_SOURCE_DIR}/Hello) 

