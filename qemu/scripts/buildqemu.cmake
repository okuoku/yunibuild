execute_process(
    COMMAND
    ./configure --enable-whpx --enable-system --enable-slirp --enable-vnc --target-list=aarch64-softmmu,arm-softmmu,avr-softmmu,riscv32-softmmu,riscv64-softmmu,x86_64-softmmu --prefix=c:/qemu
    WORKING_DIRECTORY c:/qemusrc
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Configure error")
endif()

execute_process(
    COMMAND
    ninja
    WORKING_DIRECTORY c:/qemusrc/build
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Build error")
endif()

execute_process(
    COMMAND
    ninja install
    WORKING_DIRECTORY c:/qemusrc/build
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Install error")
endif()

execute_process(
    COMMAND
    ${CMAKE_COMMAND} -E tar
    cvf c:/output/qemu.tar.gz
    qemu
    WORKING_DIRECTORY c:/
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Archive error")
endif()
