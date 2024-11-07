macro(set_output_dir_structure_single_config)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}" PARENT_SCOPE)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}" PARENT_SCOPE)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}" PARENT_SCOPE)

  set(INSTALL_BINDIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/bin" PARENT_SCOPE)
endmacro()

function(set_output_dir_structure)
  include(GNUInstallDirs)

  get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

  if(isMultiConfig)
    message(FATAL_ERROR "This project does not support multi-configuration generators.")
  else()
    set_output_dir_structure_single_config()
  endif()
endfunction()

macro(set_build_type_parameters)
  if( CMAKE_BUILD_TYPE STREQUAL "Release" )
    message(STATUS "Configuring a release build...")
    message(STATUS "C flags: ${CMAKE_C_FLAGS_RELEASE}")
  elseif( CMAKE_BUILD_TYPE STREQUAL "Debug" )
    message(STATUS "Configuring a debug build...")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0")
    message(STATUS "C flags: ${CMAKE_C_FLAGS_DEBUG}")
  else()
    message(STATUS "Build type not specified, defaulting to a release build...")
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Set build type" FORCE)
    message(STATUS "C flags: ${CMAKE_C_FLAGS_RELEASE}")
  endif()

  set(SRC_FILES "src")
  set(INCLUDE_FILES "include")
endmacro()