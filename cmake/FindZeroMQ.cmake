# - Try to find ZeroMQ
# Once done this will define
# ZeroMQ_FOUND - System has ZeroMQ
# ZeroMQ_INCLUDE_DIRS - The ZeroMQ include directories
# ZeroMQ_LIBRARIES - The libraries needed to use ZeroMQ
# ZeroMQ_DEFINITIONS - Compiler switches required for using ZeroMQ

# find_package(PkgConfig REQUIRED)
# pkg_check_modules(ZMQ REQUIRED libzmq)

# set(ZeroMQ_FOUND TRUE)
# set(ZeroMQ_INCLUDE_DIRS ${ZMQ_INCLUDE_DIRS})
# set(ZeroMQ_LIBRARIES ${ZMQ_LIBRARIES})
# First, try to use PkgConfig to find ZeroMQ

find_package(PkgConfig QUIET)
if (PKG_CONFIG_FOUND)
    pkg_check_modules(ZMQ libzmq)

    if (ZMQ_FOUND)
        message(STATUS "Found ZeroMQ using pkg-config")
        set(ZeroMQ_FOUND TRUE)
        set(ZeroMQ_INCLUDE_DIRS ${ZMQ_INCLUDE_DIRS})
        set(ZeroMQ_LIBRARIES ${ZMQ_LIBRARIES})
    else()
        message(WARNING "PkgConfig could not find ZeroMQ, falling back to manual search")
    endif()
endif()

# Fallback: if PkgConfig was not found or ZeroMQ was not found with pkg-config, use manual find
if (NOT ZeroMQ_FOUND)
    message(STATUS "Attempting to find ZeroMQ using manual search")

    find_path(ZeroMQ_INCLUDE_DIR zmq.h)
    find_library(ZeroMQ_LIBRARY NAMES zmq)

    set(ZeroMQ_LIBRARIES ${ZeroMQ_LIBRARY})
    set(ZeroMQ_INCLUDE_DIRS ${ZeroMQ_INCLUDE_DIR})

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(ZeroMQ DEFAULT_MSG ZeroMQ_LIBRARY ZeroMQ_INCLUDE_DIR)

    if (ZeroMQ_FOUND)
        message(STATUS "Found ZeroMQ using manual search")
    else()
        message(WARNING "ZeroMQ not found. Some features may be disabled.")
    endif()
endif()