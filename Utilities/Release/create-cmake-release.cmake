if(NOT DEFINED CMAKE_VERSION)
  message(FATAL_ERROR "CMAKE_VERSION not defined")
endif(NOT DEFINED CMAKE_VERSION)

set(RELEASE_SCRIPTS
  dashmacmini2_release.cmake  # Mac Darwin universal
  dashsun1_release.cmake      # SunOS
  destiny_release.cmake       # HPUX
  hythloth_release.cmake      # Linux
  muse_release.cmake          # IRIX
  muse_release64.cmake        # IRIX 64
  v60n177_aix_release.cmake   # AIX
)

file(WRITE create-${CMAKE_VERSION}.sh "#!/bin/sh")

foreach(f ${RELEASE_SCRIPTS})
  file(APPEND create-${CMAKE_VERSION}.sh
    "
${CMAKE_COMMAND} -DCMAKE_VERSION=${CMAKE_VERSION} -P ${CMAKE_ROOT}/Utilities/Release/${f} < /dev/null >& ${CMAKE_CURRENT_SOURCE_DIR}/${f}-${CMAKE_VERSION}.log &
 xterm -geometry 80x10 -sb -sl 2000 -T ${f}-${CMAKE_VERSION}.log -e tail -f  ${CMAKE_CURRENT_SOURCE_DIR}/${f}-${CMAKE_VERSION}.log&")
endforeach(f)
file(APPEND create-${CMAKE_VERSION}.sh "
echo \"ps -ef | grep ssh | grep release\"
")
execute_process(COMMAND chmod a+x create-${CMAKE_VERSION}.sh)
message("Run create-${CMAKE_VERSION}.sh")


