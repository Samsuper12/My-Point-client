set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME} 
PRIVATE
    main.cpp
    myclient.cpp
    todolist.cpp
    todomodel.cpp
    
    qml.qrc
)

target_link_libraries(${PROJECT_NAME}
PRIVATE
    Qt5::Core
    Qt5::Qml
    Qt5::Quick
    Qt5::QuickControls2
    Qt5::Multimedia
    Qt5::Positioning
    Qt5::Sql
)

target_include_directories(${PROJECT_NAME}
PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}
)

set_target_properties(${PROJECT_NAME}
PROPERTIES 
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)
    
