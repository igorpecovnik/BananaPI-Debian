#!/bin/bash
#
# Created by Igor Pecovnik, www.igorpecovnik.com
#
# Configuration 
#--------------------------------------------------------------------------------------------------------------------------------

BOARD="bananapi"						# bananapi
BRANCH="default"						# default=3.4.x, mainline=next
RELEASE="wheezy"                                   		# jessie, wheezy or trusty

# numbers
SDSIZE="1200"                               # SD image size in MB
REVISION="2.0"                              # image release version

# method
SOURCE_COMPILE="no"                        # force source compilation: yes / no
KERNEL_CONFIGURE="no"                       # want to change my default configuration
KERNEL_CLEAN="no"                          # run MAKE clean before kernel compilation
USEALLCORES="no"                           # Use all CPU cores for compiling

# user 
DEST_LANG="en_US.UTF-8"                     # sl_SI.UTF-8, en_US.UTF-8
TZDATA="Europe/Ljubljana"                   # Timezone
ROOTPWD="1234"                              # Must be changed @first login
MAINTAINER="Igor Pecovnik"                  # deb signature
MAINTAINERMAIL="igor.pecovnik@****l.com"    # deb signature

# advanced
FBTFT="yes"                                 # https://github.com/notro/fbtft 
EXTERNAL="no"                              # compile extra drivers`

#---------------------------------------------------------------------------------------

# source is where we start the script
SRC=$(pwd)

# destination
DEST=$(pwd)/output

# get updates of the main build libraries
if [ -d "$SRC/lib" ]; then
    cd $SRC/lib
    git pull 
else
    # download SDK
    git clone https://github.com/igorpecovnik/lib
fi

source $SRC/lib/main.sh
#---------------------------------------------------------------------------------------
