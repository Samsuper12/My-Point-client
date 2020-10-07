cmake_minimum_required(VERSION 3.14)

set(APP_NAME "My Point!")

project(${APP_NAME}
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

include(CmakePackageConfigHelpers)

add_subdirectory(src)
