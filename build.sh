#!/bin/bash
#
# Created by Igor Pecovnik, www.igorpecovnik.com
#
# Configuration 
#--------------------------------------------------------------------------------------------------------------------------------

BOARD="bananapi"						# bananapi, cubietruck, cubox-i, bananapi-next, cubietruck-next
RELEASE="wheezy"                                   		# jessie or wheezy
VERSION="Banana Debian 1.2 $RELEASE"               		# just name
SOURCE_COMPILE="yes"                               		# yes / no
DEST_LANG="en_US.UTF-8"                         	 	# sl_SI.UTF-8, en_US.UTF-8
TZDATA="Europe/Ljubljana"                         		# Timezone
DEST=$(pwd)/output                      		      	# Destination
ROOTPWD="1234"                               		  	# Must be changed @first login
HOST="banana"						   	# Hostname
USEALLCORES="no"				 		# Use all CPU cores for compiling
SDSIZE="1000"							# SD image size in MB

#--------------------------------------------------------------------------------------------------------------------------------

# superuser have to do this
if [ "$UID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# optimize build time with 100% CPU usage
CPUS=$(grep -c 'processor' /proc/cpuinfo)
if [ "$USEALLCORES" = "yes" ]; then
CTHREADS="-j$(($CPUS + $CPUS/2))";
else
CTHREADS="-j${CPUS}";
fi

# to display build time at the end
start=`date +%s`

clear

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

source $SRC/lib/common.sh # Functions
source $SRC/lib/boards.config # Board configuration

set -e

echo "Building $VERSION."

#--------------------------------------------------------------------------------------------------------------------------------
# Download packages for host
#--------------------------------------------------------------------------------------------------------------------------------
download_host_packages

#--------------------------------------------------------------------------------------------------------------------------------
# fetch_from_github [repository, sub directory]
#--------------------------------------------------------------------------------------------------------------------------------
mkdir -p $DEST/output
fetch_from_github "$BOOTLOADER" "$BOOTSOURCE"
fetch_from_github "$LINUXKERNEL" "$LINUXSOURCE"
fetch_from_github "$DOCS" "$DOCSDIR"
if [[ -n "$MISC1" ]]; then fetch_from_github "$MISC1" "$MISC1_DIR"; fi
if [[ -n "$MISC2" ]]; then fetch_from_github "$MISC2" "$MISC2_DIR"; fi
if [[ -n "$MISC3" ]]; then fetch_from_github "$MISC3" "$MISC3_DIR"; fi
if [[ -n "$MISC4" ]]; then fetch_from_github "$MISC4" "$MISC4_DIR"; fi

#--------------------------------------------------------------------------------------------------------------------------------
# grab linux kernel version from Makefile
#--------------------------------------------------------------------------------------------------------------------------------
VER=$(cat $DEST/$LINUXSOURCE/Makefile | grep VERSION | head -1 | awk '{print $(NF)}')
VER=$VER.$(cat $DEST/$LINUXSOURCE/Makefile | grep PATCHLEVEL | head -1 | awk '{print $(NF)}')
VER=$VER.$(cat $DEST/$LINUXSOURCE/Makefile | grep SUBLEVEL | head -1 | awk '{print $(NF)}')
EXTRAVERSION=$(cat $DEST/$LINUXSOURCE/Makefile | grep EXTRAVERSION | head -1 | awk '{print $(NF)}')
if [ "$EXTRAVERSION" != "=" ]; then VER=$VER$EXTRAVERSION; fi



if [ "$SOURCE_COMPILE" = "yes" ]; then
#--------------------------------------------------------------------------------------------------------------------------------
# Compiling everything
#--------------------------------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------------------------------
# Patching sources
#--------------------------------------------------------------------------------------------------------------------------------
cd $DEST/$LINUXSOURCE
if [[ $LINUXSOURCE == "linux-sunxi" ]] ; then
	patch --batch -N -p1 < $SRC/patch/gpio.patch
	patch --batch -N -p1 < $SRC/patch/spi.patch
	if [[ $BOARD == "bananapi" ]] ; then
		patch --batch -N -p1 < $SRC/patch/bananagmac.patch
	fi
fi
if [[ $LINUXSOURCE == "linux-cubox-next" ]] ; then
	patch --batch -N -p1 < $SRC/patch/hb-i2c-spi.patch
fi
# compile sunxi tools
compile_sunxi_tools
# compile boot loader
compile_uboot 
# compile kernel and create archives
compile_kernel
# create tar file
packing_kernel
fi

# check if previously build kernel file exits
if [ ! -f "$DEST/output/"$BOARD"_kernel_"$VER"_mod_head_fw.tar" ]; then 
	echo "Previously compiled kernel does not exits. Please choose compile=yes in configuration and run again!"
	exit 
fi

# prepare image with bootloader
creating_image
# install base system
install_base_debian 
# install additional applications
install_applications
# install board specific applications
install_board_specific 
# install external applications
install_external_applications
# add some summary to the image
fingerprint_image "$DEST/output/sdcard/root/readme.txt"
# closing image
closing_image
#
end=`date +%s`
runtime=$(((end-start)/60))
echo "Runtime $runtime min."
