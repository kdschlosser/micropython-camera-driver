# Create an INTERFACE library for our C module.
add_library(usermod_esp32camera INTERFACE)

# Add our source files to the lib
target_sources(usermod_esp32camera INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/modcamera.c
)

set(MOD_INCLUDES ${CMAKE_CURRENT_LIST_DIR})

# gets esp_lcd include paths
idf_component_get_property(CAMERA_INCLUDES esp32-camera INCLUDE_DIRS)
idf_component_get_property(CAMERA_PRIV_INCLUDES esp32-camera PRIV_INCLUDE_DIRS)

# gets the path to the component
idf_component_get_property(CAMERA_DIR esp32-camera COMPONENT_DIR)

# sets the include paths into MOD_INCLUDES variable
if(CAMERA_INCLUDES)
    list(TRANSFORM CAMERA_INCLUDES PREPEND ${CAMERA_DIR}/)
    list(APPEND MOD_INCLUDES ${CAMERA_INCLUDES})
endif()

if(CAMERA_PRIV_INCLUDES)
    list(TRANSFORM CAMERA_PRIV_INCLUDES PREPEND ${CAMERA_DIR}/)
    list(APPEND MOD_INCLUDES ${CAMERA_PRIV_INCLUDES})
endif()

# Add the current directory as an include directory.
target_include_directories(usermod_esp32camera INTERFACE ${MOD_INCLUDES})

target_compile_definitions(usermod_esp32camera INTERFACE)

# Link our INTERFACE library to the usermod target.
target_link_libraries(usermod INTERFACE usermod_esp32camera)