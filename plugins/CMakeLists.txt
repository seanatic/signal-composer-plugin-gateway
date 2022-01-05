###########################################################################
# Copyright 2021 "IoT.bzh"
#
# Author: Valentin Lefebvre <valentin.lefebvre@iot.bzh>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###########################################################################
PROJECT_TARGET_ADD(${PROJECT_NAME})

# Store the json config file
CONFIGURE_FILE(
	${CMAKE_SOURCE_DIR}/${PROJECT_JSON_CONF_DIR}/configs.json
	${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_CONF_NAME}
)

# Add project like library
ADD_LIBRARY(${TARGET_NAME} MODULE
	${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.cpp
)

# Config the source file
CONFIGURE_FILE(
	${CMAKE_CURRENT_SOURCE_DIR}/source.cpp
	${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.cpp
)

# Include all necessary include
TARGET_INCLUDE_DIRECTORIES(${TARGET_NAME} PUBLIC
	${composer_INCLUDEDIR}
	${helpers_LIBRARIES}
	${controller_INCLUDEDIR}
)

# Link to all necessary library
TARGET_LINK_LIBRARIES(${TARGET_NAME}
	signal-composer ${composer_LIBRARIES} -L${composer_LIBDIR}
	${helpers_LIBRARIES} -L${helpers_LIBDIR}
	${controller_LIBRARIES} -L${controller_LIBDIR}
)

# Set project porperty for signal composer plugin
SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES
	LABELS "PLUGIN"
	PREFIX ""
	SUFFIX ${PLUGIN_SUFFIX}
	OUTPUT_NAME ${TARGET_NAME}
	INSTALL_RPATH "$ORIGIN:$ORIGIN/.."
	BUILD_RPATH "$ORIGIN:$ORIGIN/.."
)

# Add the plugin config file installation rule
ADD_CUSTOM_TARGET( install_${TARGET_NAME}
	COMMAND install -d \${DESTDIR}/${CMAKE_INSTALL_PREFIX}/${composer_MODULE_NAME}/lib/plugins
	COMMAND install ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}${PLUGIN_SUFFIX} \${DESTDIR}/${CMAKE_INSTALL_PREFIX}/${composer_MODULE_NAME}/lib/plugins 
	COMMAND ${CMAKE_COMMAND} -E echo "-- installing: ${CMAKE_INSTALL_PREFIX}/${composer_MODULE_NAME}/lib/plugins/${TARGET_NAME}${PLUGIN_SUFFIX}"
	COMMAND install -d \${DESTDIR}/${CMAKE_INSTALL_PREFIX}/${composer_MODULE_NAME}/etc
	COMMAND install -m 0644 ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_CONF_NAME} \${DESTDIR}/${CMAKE_INSTALL_PREFIX}/${composer_MODULE_NAME}/etc
	COMMAND ${CMAKE_COMMAND} -E echo "-- installing: ${CMAKE_INSTALL_PREFIX}/${composer_MODULE_NAME}/etc/${PROJECT_CONF_NAME}"
)
