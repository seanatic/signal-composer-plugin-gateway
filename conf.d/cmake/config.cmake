###########################################################################
# Copyright 20201 IoT.bzh
#
# author: LEFEBVRE Valentin <valentin.lefebvre@iot.bzh>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###########################################################################

# Include
# ------------------
include(FindPkgConfig)

# Project Info
# ------------------
set(PROJECT_NAME signal-composer-plugins-seanatic-gateway)
set(PROJECT_VERSION "1.0.0")
set(PROJECT_PRETTY_NAME "Signal composer plugin seanatic gateway")
set(PROJECT_DESCRIPTION "A signal composer plugin meant to catch data from modbus and send it to redis database")
set(PROJECT_URL "http://git.ovh.iot/seanatic/signal-composer-plugin-seanatic-gateway")
set(PROJECT_ICON "icon.png")
set(PROJECT_AUTHOR "Valentin Lefebvre")
set(PROJECT_AUTHOR_MAIL "valentin.lefebvre@iot.bzh")
set(PROJECT_LICENSE "APL2.0")
set(PROJECT_LANGUAGES "CXX")
set(PLUGIN_SUFFIX ".ctlso")
set(DEMO_SENSOR "SIEMENS_ET200SP")

# Where are stored default templates files from submodule or subtree app-templates in your project tree
# relative to the root project directory
set(PROJECT_CMAKE_CONF_DIR "conf.d/cmake")
set(PROJECT_JSON_CONF_DIR "conf.d/etc")
set(PROJECT_VAR_DIR "/${PROJECT_CMAKE_CONF_DIR}/var")
set(PROJECT_CONF_NAME "${PROJECT_NAME}.json")

# Compilation Mode (DEBUG, RELEASE)
# ----------------------------------
set(BUILD_TYPE "RELEASE")

# Kernel selection if needed. You can choose between a
# mandatory version to impose a minimal version.
# Or check Kernel minimal version and just print a Warning
# about missing features and define a preprocessor variable
# to be used as preprocessor condition in code to disable
# incompatibles features. Preprocessor define is named
# KERNEL_MINIMAL_VERSION_OK.
#
# NOTE*** FOR NOW IT CHECKS KERNEL Yocto environment and
# Yocto SDK Kernel version.
# -----------------------------------------------
set (kernel_minimal_version 4.8)

# Compiler selection if needed. Impose a minimal version.
# -----------------------------------------------
set (gcc_minimal_version 4.9)

# PKG_CONFIG required packages
# -----------------------------
pkg_check_modules(composer REQUIRED signal-composer-binding)
pkg_check_modules(helpers REQUIRED afb-libhelpers)
pkg_check_modules(controller REQUIRED afb-libcontroller)

# Compilation options definition
# Use CMake generator expressions to specify only for a specific language
# Values are prefilled with default options that is currently used.
# Either separate options with ";", or each options must be quoted separately
# DO NOT PUT ALL OPTION QUOTED AT ONCE , COMPILATION COULD FAILED !
# ----------------------------------------------------------------------------
set(COMPILE_OPTIONS 
    "-Wall" 
    "-Wextra" 
    "-Wconversion" 
    "-Wno-unused-parameter" 
    "-Wno-sign-compare" 
    "-Wno-sign-conversion" 
    "-Werror=maybe-uninitialized" 
    "-ffunction-sections" 
    "-fdata-sections" 
    "-fPIC" 
    CACHE STRING "Compilation flags"
)

# (BUG!!!) as PKG_CONFIG_PATH does not work [should be an env variable]
# ---------------------------------------------------------------------
set(INSTALL_PREFIX /var/local/lib/afm/applications/)
set(CMAKE_PREFIX_PATH ${CMAKE_INSTALL_PREFIX}/lib64/pkgconfig ${CMAKE_INSTALL_PREFIX}/lib/pkgconfig)
set(LD_LIBRARY_PATH ${CMAKE_INSTALL_PREFIX}/lib64 ${CMAKE_INSTALL_PREFIX}/lib)

# Print example message to run binding
# ------------------------------------
set(WIDGET_ENTRY_POINT lib/afb-signal-composer-binding.so)
set(AFB_REMPORT "1234" CACHE PATH "Default binder listening port")
set(CLOSING_MESSAGE "Typical binding launch: afb-binder --workdir=/var/local/lib/afm/applications/signal-composer-binding/ --port=${AFB_REMPORT} --name=afb-signal-composer-binding --binding=${WIDGET_ENTRY_POINT} --ws-client=unix:@modbus")
include(CMakeAfbTemplates)
