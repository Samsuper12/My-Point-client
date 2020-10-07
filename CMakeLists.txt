cmake_minimum_required(VERSION 3.14)

project(my_point_client
    LANGUAGES CXX
    VERSION 0.1
)

find_package(Qt5 CONFIG REQUIRED 
    Core
    Qml
    Quick
    QuickControls2
    Multimedia
    Sql
    Positioning
)

include(CMakePackageConfigHelpers)

add_subdirectory(src)
