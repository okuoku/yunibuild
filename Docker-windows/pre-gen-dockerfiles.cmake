# Standard baseimage(LTSC2022 for GitHub Actions)
set(BASEIMAGE mcr.microsoft.com/windows/servercore:ltsc2022)
configure_file(Dockerfile-cygwin.in Dockerfile-cygwin.ltsc2022)
configure_file(Dockerfile-msvc17.in Dockerfile-msvc17.ltsc2022)

# On Windows10, 2004 is only suitable image for it
set(BASEIMAGE mcr.microsoft.com/windows/servercore:2004)
configure_file(Dockerfile-cygwin.in Dockerfile-cygwin.win10desktop)
configure_file(Dockerfile-msvc17.in Dockerfile-msvc17.win10desktop)
