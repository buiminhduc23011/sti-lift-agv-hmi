cmake_minimum_required(VERSION 3.16)

project(AGVControl VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON) # Explicitly enable AUTOMOC
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick Widgets)

# qt_standard_project_setup() # Removing this to avoid version dependency issues if < 6.3

set(PROJECT_SOURCES
    src/main.cpp
    src/AgvController.cpp
    src/AgvController.h
    resources/qml.qrc
)

qt_add_executable(AGVControl
    MANUAL_FINALIZATION
    ${PROJECT_SOURCES}
)

target_link_libraries(AGVControl
    PRIVATE Qt6::Quick Qt6::Widgets
)

# QML resources are handled by the qrc file
qt_finalize_executable(AGVControl)
