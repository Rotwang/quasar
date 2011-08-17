project(quasar C)
cmake_minimum_required(VERSION 2.6)

find_package(LibXml2)
find_package(CURL)

add_definitions(-ggdb3 -Wall -Wextra -std=c99 -pedantic)

add_subdirectory(src)
