set(BASEIMAGE mcr.microsoft.com/windows/servercore:ltsc2022)
configure_file(Dockerfile.in Dockerfile.ltsc2022)

# On Windows10, 2004 is only suitable image for it
set(BASEIMAGE mcr.microsoft.com/windows/servercore:2004)
configure_file(Dockerfile.in Dockerfile.win10desktop)
