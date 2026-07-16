# spdlog v1.x
set(_spdlog_local_dir "${CMAKE_CURRENT_LIST_DIR}/spdlog-1.9.2")
if(EXISTS "${_spdlog_local_dir}/CMakeLists.txt")
    add_subdirectory(${_spdlog_local_dir} ${CMAKE_BINARY_DIR}/_deps/spdlog-local-build)
else()
    find_path(SPDLOG_INCLUDE_DIR NAMES spdlog/spdlog.h)
    find_package(fmt CONFIG QUIET)
    if(SPDLOG_INCLUDE_DIR AND fmt_FOUND)
        message(STATUS "Using header-only spdlog from ${SPDLOG_INCLUDE_DIR} with system fmt")
        add_library(spdlog INTERFACE)
        add_library(spdlog::spdlog ALIAS spdlog)
        target_include_directories(spdlog SYSTEM INTERFACE ${SPDLOG_INCLUDE_DIR})
        target_compile_definitions(spdlog INTERFACE SPDLOG_HEADER_ONLY SPDLOG_FMT_EXTERNAL)
        target_link_libraries(spdlog INTERFACE fmt::fmt)
    else()
        FetchContent_Declare(
            spdlog
            GIT_REPOSITORY https://github.com/gabime/spdlog.git
            GIT_TAG        v1.9.2
        )
        FetchContent_MakeAvailable(spdlog)
    endif()
endif()
