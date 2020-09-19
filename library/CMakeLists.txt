cmake_minimum_required(VERSION 3.15)

project(ExampleCppLib VERSION 1.0.0 LANGUAGES CXX)

# Library

include(GNUInstallDirs)

set(target_name examplecpplib)
set(src_files "src/example_class.cpp")
set(include_files "include/${target_name}/example_class.hpp")

add_library(${target_name} STATIC ${src_files})
add_library(${PROJECT_NAME}::${target_name} ALIAS ${target_name})

set_target_properties(${target_name} PROPERTIES
    PUBLIC_HEADER ${include_files}
    EXPORT_NAME ${target_name}
)

target_include_directories(${target_name}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_compile_features(${target_name} PRIVATE cxx_std_11)

# Installation

set(install_configdir ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

install(TARGETS ${target_name}
    EXPORT ${target_name}-targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${target_name}
)

install(EXPORT ${target_name}-targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${install_configdir}
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/cmake/${PROJECT_NAME}Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION ${install_configdir}
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    DESTINATION ${install_configdir}
)

export(EXPORT ${target_name}-targets
    FILE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
)

export(PACKAGE ${PROJECT_NAME})
