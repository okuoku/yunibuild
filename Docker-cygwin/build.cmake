execute_process(COMMAND
    ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_LIST_DIR}/pre-gen-dockerfiles.cmake
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    RESULT_VARIABLE rr
    )

if(rr)
    message(FATAL_ERROR "Err1")
endif()

execute_process(COMMAND
    ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_LIST_DIR}/pre-gen-cygwin.cmake
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    RESULT_VARIABLE rr
    )

if(rr)
    message(FATAL_ERROR "Err2")
endif()

execute_process(COMMAND
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    docker build -f Dockerfile.ltsc2022 --tag ghcr.io/okuoku/yunibuild-cygwin-ltsc2022 .
    RESULT_VARIABLE rr
    )

if(rr)
    message(FATAL_ERROR "Err3")
endif()
