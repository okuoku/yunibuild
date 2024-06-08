find_program(cygpath cygpath)
set(root0 ${CMAKE_CURRENT_LIST_DIR})
cmake_path(ABSOLUTE_PATH root0 NORMALIZE OUTPUT_VARIABLE root0)
message(STATUS ${root0})
if(cygpath)
    execute_process(COMMAND ${cygpath} -m ${root0}
        OUTPUT_VARIABLE root0
        OUTPUT_STRIP_TRAILING_WHITESPACE
        RESULT_VARIABLE rr)
    if(rr)
        message(FATAL_ERROR "Failed to convert path")
    endif()
endif()

message(STATUS "root = ${root0}")

set(out ${root0}/bin)
file(MAKE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/bin)

if(NOT IN_CONTAINER)
    execute_process(COMMAND
        docker run --rm
        -v ${root0}:c:/source:ro
        -v ${out}:c:/out:rw
        yunibuild-msvc17
        "c:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe"
        -DIN_CONTAINER=ON
        -P c:/source/build-win.cmake
        RESULT_VARIABLE rr
        )
    if(rr)
        message(FATAL_ERROR "Failed to launch container")
    endif()
else()
    message(STATUS "Configure(execlogger)...")
    set(vcvars64 "c:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat")
    file(MAKE_DIRECTORY c:/build)
    execute_process(COMMAND
        cmd /c ${vcvars64} && cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
        c:/source/execlogger
        RESULT_VARIABLE rr
        WORKING_DIRECTORY c:/build)
    if(rr)
        message(FATAL_ERROR "Configure error")
    endif()
    message(STATUS "Build(execlogger)...")
    execute_process(COMMAND
        cmd /c ${vcvars64} && ninja
        RESULT_VARIABLE rr
        WORKING_DIRECTORY c:/build)
    if(rr)
        message(FATAL_ERROR "Build error")
    endif()

    file(COPY_FILE 
        c:/build/execlogger.exe
        c:/out/execlogger.exe
        INPUT_MAY_BE_RECENT)
endif()
