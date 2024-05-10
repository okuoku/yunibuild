# Prepare setup.exe and ASLR disabled Cygwin1.dll

find_program(cygpath cygpath)
# Fetch https://cygwin.com/setup-x86_64.exe
file(DOWNLOAD https://cygwin.com/setup-x86_64.exe setup-x86_64.exe
    SHOW_PROGRESS
    LOG log
    )

message(STATUS ${log})

if(cygpath)
    # if we're on Cygwin, chmod +x setup-x86_64
    execute_process(COMMAND
        chmod +x setup-x86_64.exe)
endif()

# Pass1: Install plain Cygwin on host
execute_process(COMMAND
    setup-x86_64.exe -s http://ftp.iij.ad.jp/pub/cygwin -R "c:\\cygsetup64" -l "c:\\cache64"
    -B -v -q -N -d -g
    RESULT_VARIABLE rr
    )

if(rr)
    message(FATAL_ERROR "Local cygwin install failed (${rr})")
endif()

# Extract cygwin1.dll
execute_process(COMMAND
    c:/cygsetup64/bin/cp c:/cygsetup64/bin/cygwin1.dll .
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Couldn't extract cygwin1.dll")
endif()

# Rename
file(RENAME cygwin1.dll noaslr-cygwin1.dll)

# peedit
execute_process(COMMAND
    c:/cygsetup64/bin/peflags.exe -d0 noaslr-cygwin1.dll 
    RESULT_VARIABLE rr)

if(rr)
    message(FATAL_ERROR "Couldn't edit cygwin1.dll")
endif()
