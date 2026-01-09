cmake_minimum_required(VERSION 3.16)

project(AGVControl VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick Widgets)

qt_standard_project_setup()

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

# QML resources are handled by the qrc file, but we also can use qt_add_qml_module if we were fully modern,
# but a simple qrc approach is often robust for simple structures.
# However, Qt6 encourages qt_add_qml_module. Let's try the simple qrc approach first for file structure control.
