set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(EDL_SEARCH_PATHS Enclave Enclave/TrustedLibrary)

set(E_SRCS Enclave/Enclave.cpp)
#set(T_SRCS Enclave/TrustedLibrary/Libcxx.cpp)
if(SGX_HW AND SGX_MODE STREQUAL "Release")
    set(LDS Enclave/Enclave.lds)
else()
    set(LDS Enclave/Enclave_debug.lds)
endif()
#add_trusted_library(trusted_lib SRCS ${T_SRCS} EDL Enclave/TrustedLibrary/Libcxx.edl EDL_SEARCH_PATHS ${EDL_SEARCH_PATHS})

#add_enclave_library(enclave SRCS ${E_SRCS} TRUSTED_LIBS trusted_lib EDL Enclave/Enclave.edl EDL_SEARCH_PATHS ${EDL_SEARCH_PATHS} LDSCRIPT ${LDS})
add_enclave_library(enclave SRCS ${E_SRCS} EDL Enclave/Enclave.edl EDL_SEARCH_PATHS ${EDL_SEARCH_PATHS} LDSCRIPT ${LDS})
enclave_sign(enclave KEY Enclave/Enclave_private.pem CONFIG Enclave/Enclave.config.xml)
#set(SRCS App/App.cpp App/TrustedLibrary/Libcxx.cpp)
set(SRCS App/App.cpp)
add_untrusted_executable(Hello SRCS ${SRCS} EDL Enclave/Enclave.edl EDL_SEARCH_PATHS ${EDL_SEARCH_PATHS})
