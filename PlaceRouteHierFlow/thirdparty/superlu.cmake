# superlu v6.0.0
FetchContent_Declare(
    superlu
    GIT_REPOSITORY https://github.com/xiaoyeli/superlu.git
    GIT_TAG        v6.0.0
)
FetchContent_GetProperties(superlu)
if(NOT superlu_POPULATED)
    FetchContent_Populate(superlu)
endif()
FetchContent_GetProperties(superlu SOURCE_DIR superlu_SOURCE_DIR BINARY_DIR superlu_BINARY_DIR)
file(GLOB _superlu_io_sources "${superlu_SOURCE_DIR}/SRC/*read*.c")
foreach(_src IN LISTS _superlu_io_sources)
    file(READ "${_src}" _src_content)
    string(REGEX REPLACE "FILE \\*fopen\\(\\);[ \t]*\n" "" _src_content "${_src_content}")
    file(WRITE "${_src}" "${_src_content}")
endforeach()
if(NOT TARGET superlu)
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/PlaceRouteHierFlow/thirdparty/CMakeLists.superlu
        ${superlu_SOURCE_DIR}/CMakeLists.txt
        COPYONLY)
    add_subdirectory(${superlu_SOURCE_DIR} ${superlu_BINARY_DIR})
endif()
