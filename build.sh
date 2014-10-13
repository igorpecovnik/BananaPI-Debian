#!/bin/bash
#
# Created by Igor Pecovnik, www.igorpecovnik.com
#
# Configuration 
#--------------------------------------------------------------------------------------------------------------------------------

BOARD="bananapi"						# bananapi, cubietruck, cubox-i, bananapi-next, cubietruck-next
RELEASE="wheezy"                                   		# jessie or wheezy
VERSION="Banana Debian 1.3 $RELEASE"               		# just name
SOURCE_COMPILE="yes"                               		# yes / no
DEST_LANG="en_US.UTF-8"                         	 	# sl_SI.UTF-8, en_US.UTF-8
TZDATA="Europe/Ljubljana"                         		# Timezone
DEST=$(pwd)/output                      		      	# Destination
ROOTPWD="1234"                               		  	# Must be changed @first login
HOST="banana"						 	# Hostname
USEALLCORES="no"						# Use all CPU cores for compiling
SDSIZE="1000"							# SD image size in MB
FBTFT="yes"							# Small TFT support, https://github.com/notro/fbtft

#--------------------------------------------------------------------------------------------------------------------------------
# superuser have to do this
if [ "$UID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# source is where we start the script
SRC=$(pwd)

# get updates of the main build libraries
if [ -d "$SRC/lib" ]; then
	cd $SRC/lib
	git pull 
else
	git clone https://github.com/igorpecovnik/lib lib
fi
cd $SRC

source $SRC/lib/boards.config # Board configuration
source $SRC/lib/common.sh # Functions
source $SRC/lib/main.sh # Main
#--------------------------------------------------------------------------------------------------------------------------------
