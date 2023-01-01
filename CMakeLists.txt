cmake_minimum_required(VERSION 3.24)
project(quickclipboard)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_PREFIX_PATH "/home/youssef/Qt/6.4.1/gcc_64")

find_package(Qt6 COMPONENTS
        Core
        Widgets
        Sql
        REQUIRED)

enable_language("RC")
set(app_icon_resource_windows "${CMAKE_CURRENT_SOURCE_DIR}/quickclipboard.rc")
add_executable(quickclipboard WIN32 main.cpp imgs.qrc TextRepository.h Text.h TextRepository.cpp App.cpp App.h AddNewTextDialog.cpp AddNewTextDialog.h ${app_icon_resource_windows})

target_link_libraries(quickclipboard
        Qt::Core
        Qt::Widgets
        Qt::Sql
        )
