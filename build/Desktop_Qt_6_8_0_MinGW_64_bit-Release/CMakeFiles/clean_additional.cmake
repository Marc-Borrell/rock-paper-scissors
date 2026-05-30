# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "A13044_autogen"
  "CMakeFiles\\A13044_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\A13044_autogen.dir\\ParseCache.txt"
  )
endif()
