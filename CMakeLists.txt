project(quasar C)
cmake_minimum_required(VERSION 2.6)

find_package(LibXml2)
find_package(CURL)

add_subdirectory(src)
