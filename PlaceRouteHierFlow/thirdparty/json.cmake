# json v3.7.3
find_package(nlohmann_json 3.7.3 QUIET)
if(NOT nlohmann_json_FOUND)
    set(_json_local_dir "${CMAKE_CURRENT_LIST_DIR}/nlohmann_json")
    if(EXISTS "${_json_local_dir}/include/nlohmann/json.hpp")
        add_library(nlohmann_json INTERFACE)
        add_library(nlohmann_json::nlohmann_json ALIAS nlohmann_json)
        target_include_directories(nlohmann_json SYSTEM INTERFACE "${_json_local_dir}/include")
    else()
        FetchContent_Declare(
            json
            GIT_REPOSITORY https://github.com/ArthurSonzogni/nlohmann_json_cmake_fetchcontent
            GIT_TAG v3.7.3
        )
        FetchContent_MakeAvailable(json)
    endif()
endif()
