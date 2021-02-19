#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2020 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="pokerp"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
        export PLATFORM_VERSION="16.1.0"
   	export PLATFORM_SECURITY_PATCH="2099-12-31"
   	export TW_DEFAULT_LANGUAGE="en"
	export OF_SCREEN_H="2340"
        export OF_STATUS_H="83"
        export OF_STATUS_INDENT_LEFT="52"
        export OF_STATUS_INDENT_RIGHT="52"
	export OF_HIDE_NOTCH="1"
	#export OF_NO_SPLASH_CHANGE="1"
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"
	export OF_USE_SYSTEM_FINGERPRINT="1"
	
	export FOX_USE_NANO_EDITOR="1"
	export FOX_USE_TAR_BINARY="1"
	export FOX_USE_ZIP_BINARY="1"
	export OF_USE_NEW_MAGISKBOOT="1"
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP="1"
	export OF_VANILLA_BUILD="1"
	export OF_DISABLE_UPDATEZIP="1"
	export OF_FLASHLIGHT_ENABLE="0"
	
	#Build type and mantainer info
	export OF_MAINTAINER="KatoTempest"
        export FOX_BUILD_TYPE="Unofficial"

	# OTA for custom ROMs
        export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES="1"
        export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR="1"

        # -- add settings for R11 --
        export FOX_R11="1"
        export OF_USE_TWRP_SAR_DETECT="1"
        export OF_DISABLE_MIUI_OTA_BY_DEFAULT="1"
        export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"
        # -- end R11 settings --

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

	add_lunch_combo omni_"$FDEVICE"-eng
	add_lunch_combo omni_"$FDEVICE"-userdebug
fi
#
