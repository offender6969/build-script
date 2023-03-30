#! /bin/bash
# shellcheck disable=SC2154

 # Script For Building Android arm64 Kernel
 #
 # Copyright (c) 2018-2021 Panchajanya1999 <rsk52959@gmail.com>
 #
 # Licensed under the Apache License, Version 2.0 (the "License");
 # you may not use this file except in compliance with the License.
 # You may obtain a copy of the License at
 #
 #      http://www.apache.org/licenses/LICENSE-2.0
 #
 # Unless required by applicable law or agreed to in writing, software
 # distributed under the License is distributed on an "AS IS" BASIS,
 # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 # See the License for the specific language governing permissions and
 # limitations under the License.
 #
 #change which one you want to use (default aosp)
 CLANG=aosp

#Clone AnyKernel
        if [ -d AnyKernel3 ]; then
		  rm -rf AnyKernel3 && git clone https://github.com/Ghosuto/AnyKernel3.git AnyKernel3
		else
          git clone https://github.com/Ghosuto/AnyKernel3.git AnyKernel3
		fi

#clang
echo "cloning clang"
		if [ "${CLANG}" = "proton" ]; then
		echo "proton"
			git clone --depth=1  https://github.com/kdrag0n/proton-clang.git clang
        elif [ "${CLANG}" = "sd" ]; then
        echo "sd"
			git clone https://gitlab.com/VoidUI/snapdragon-clang.git clang
		elif [ "${CLANG}" = "zyc" ]; then
		echo "zyc"
			git clone https://gitlab.com/GhosutoX/zyc-clang16.git clang
		elif [ "${CLANG}" = "weebx" ]; then
		echo "weebx"
		    git clone https://gitlab.com/GhosutoX/weebx-clang16.git clang
		elif [ "${CLANG}" = "aosp" ]; then
		echo "aosp"
		    git clone --depth=1 https://gitlab.com/GhosutoX/aosp-clang-17.0.0.git clang
    elif [ "${CLANG}" = "zyc17" ]; then
        echo "zyc"
		    mkdir clang && cd clang
		    wget https://raw.githubusercontent.com/ZyCromerZ/Clang/main/Clang-main-lastbuild.txt
		    V="$(cat Clang-main-lastbuild.txt)"
            wget -q https://github.com/ZyCromerZ/Clang/releases/download/17.0.0-$V-release/Clang-17.0.0-$V.tar.gz
	        tar -xf Clang-17.0.0-$V.tar.gz
	        cd ..
		fi

##------------------------------------------------------##

#Kernel building script
# debug
set -x

# Bail out if script fails
set -e

# Function to show an informational message
msg() {
	echo
	echo -e "\e[1;32m$*\e[0m"
	echo
}

err() {
	echo -e "\e[1;41m$*\e[0m"
	exit 1
}

cdir() {
	cd "$1" 2>/dev/null || \
		err "The directory $1 doesn't exists !"
}

##------------------------------------------------------##
##----------Basic Informations, COMPULSORY--------------##

# The defult directory where the kernel should be placed
KERNEL_DIR="$(pwd)"
BASEDIR="$(basename "$KERNEL_DIR")"

# Set if compiler toolchain is not in $PATH
BUILDTOOLS_PREFIX=$(pwd)/clang
PATH="${BUILDTOOLD_PREFIX}/bin:${PATH}"
#ln -sf "${BUILDTOOLS_PREFIX}" "$(pwd)/clang-llvm"

# The name of the Kernel, to name the ZIP
ZIPNAME="N0Kernel-clang17-lto-polly"

# Build Author
# Take care, it should be a universal and most probably, case-sensitive
AUTHOR="Ghosuto"

# Architecture
ARCH=arm64

# The name of the device for which the kernel is built
MODEL="Poco F3"

# The codename of the device
DEVICE="alioth"

# The defconfig which should be used. Get it from config.gz from
# your device or check source
if [ "${DEVICE}" = "alioth" ]; then
DEFCONFIG=vendor/alioth_defconfig
MODEL="Poco F3"
elif [ "${DEVICE}" = "alioth2" ]; then
DEFCONFIG=alioth_defconfig
MODEL="Poco F3"
fi

# Specify compiler. 
# 'clang' or 'gcc'
COMPILER=clang

# Build modules. 0 = NO | 1 = YES
MODULES=0

# Specify linker.
# 'ld.lld'(default)
LINKER=ld.lld

# Clean source prior building. 1 is NO(default) | 0 is YES
INCREMENTAL=0

# Generate a full DEFCONFIG prior building. 1 is YES | 0 is NO(default)
DEF_REG=0

# Files/artifacts
FILES=Image

# Build dtbo.img (select this only if your source has support to building dtbo.img)
# 1 is YES | 0 is NO(default)
BUILD_DTBO=1
	if [ $BUILD_DTBO = 1 ]
	then 
		# Set this to your dtbo path. 
		# Defaults in folder out/arch/arm64/boot/dts
		DTBO_PATH="out/arch/arm64/boot/dts/vendor/qcom"
	fi

# Verbose build
# 0 is Quiet(default)) | 1 is verbose | 2 gives reason for rebuilding targets
VERBOSE=0

# Debug purpose. Send logs on every successfull builds
# 1 is YES | 0 is NO(default)
LOG_DEBUG=0

##------------------------------------------------------##
##---------Do Not Touch Anything Beyond This------------##

# Check if we are using a dedicated CI ( Continuous Integration ), and
# set KBUILD_BUILD_VERSION and KBUILD_BUILD_HOST and CI_BRANCH

## Set defaults first



# shellcheck source=/etc/os-release
DISTRO=$(source /etc/os-release && echo "${NAME}")
KBUILD_BUILD_HOST=Hypermind
TERM=xterm
export KBUILD_BUILD_HOST CI_BRANCH TERM

#Check Kernel Version
KERVER=$(make kernelversion)

# Set a commit head
COMMIT_HEAD=$(git log --oneline -1)

# Set Date 
DATE=$(TZ=CET date +"%Y%m%d")

#Now Its time for other stuffs like cloning, exporting, etc

 clone() {
	echo " "

	#if [ $COMPILER = "clang" ]
	#then
#		msg "|| Cloning Clang-14 ||"
#		TC_DIR=$KERNEL_DIR/clang-llvm
#	fi
}

##------------------------------------------------------##

exports() {
	KBUILD_BUILD_USER=$AUTHOR
	SUBARCH=$ARCH

		KBUILD_COMPILER_STRING=$(${BUILDTOOLS_PREFIX}/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')
		PATH=$BUILDTOOLS_PREFIX/bin/:$PATH

	PROCS=$(nproc --all)

	export KBUILD_BUILD_USER ARCH SUBARCH PATH \
		KBUILD_COMPILER_STRING PROCS
}

##---------------------------------------------------------##

build_kernel() {
	if [ $INCREMENTAL = 0 ]
	then
		msg "|| Cleaning Sources ||"
		make clean && rm -rf out
		git restore drivers/input/touchscreen/focaltech_touch/include/firmware/fw_sample.i drivers/input/touchscreen/focaltech_spi/include/firmware/fw_ft3658_k11.i drivers/input/touchscreen/focaltech_spi/include/firmware/fw_sample.i drivers/input/touchscreen/focaltech_touch/include/firmware/fw_ft3518_j11.i drivers/input/touchscreen/focaltech_touch/include/firmware/fw_sample.i drivers/input/touchscreen/focaltech_touch/include/pramboot/FT8719_Pramboot_V0.5_20171221.i
	fi


	BUILD_START=$(date +"%s")


  MAKE+=(
	  CROSS_COMPILE=aarch64-linux-gnu- \
		CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
		CC=${BUILDTOOLS_PREFIX}/bin/clang \
		AR=${BUILDTOOLS_PREFIX}/bin/llvm-ar \
		AS=${BUILDTOOLS_PREFIX}/bin/llvm-as \
		OBJDUMP=${BUILDTOOLS_PREFIX}/bin/llvm-objdump \
		STRIP=${BUILDTOOLS_PREFIX}/bin/llvm-strip \
		NM=${BUILDTOOLS_PREFIX}/bin/llvm-nm \
		OBJCOPY=${BUILDTOOLS_PREFIX}/bin/llvm-objcopy \
		LD=${BUILDTOOLS_PREFIX}/bin/${LINKER} \
		LLVM=1 \
		LLVM_IAS=1
  )

	make O=out "${MAKE[@]}" $DEFCONFIG

	msg "|| Started Compilation ||"
	make -kj"$PROCS" O=out \
		V=$VERBOSE \
		"${MAKE[@]}" 2>&1 | tee error.log
	if [ $MODULES = "1" ]
	then
	    msg "|| Started Compiling Modules ||"
	    make -j"$PROCS" O=out \
		 "${MAKE[@]}" modules_prepare
	    make -j"$PROCS" O=out \
		 "${MAKE[@]}" modules INSTALL_MOD_PATH="$KERNEL_DIR"/out/modules
	    make -j"$PROCS" O=out \
		 "${MAKE[@]}" modules_install INSTALL_MOD_PATH="$KERNEL_DIR"/out/modules
	    find "$KERNEL_DIR"/out/modules -type f -iname '*.ko' -exec cp {} AnyKernel3/modules/system/lib/modules/ \;
	fi

		BUILD_END=$(date +"%s")
		DIFF=$((BUILD_END - BUILD_START))

		if [ -f "$KERNEL_DIR"/out/arch/arm64/boot/$FILES ]
		then
			msg "|| Kernel successfully compiled ||"
				gen_zip
		fi

}

##--------------------------------------------------------------##

gen_zip() {
	msg "|| Zipping into a flashable zip ||"
	mv "$KERNEL_DIR"/out/arch/arm64/boot/$FILES AnyKernel3/$FILES
	if [ $BUILD_DTBO = 1 ]
	then
		mv "$KERNEL_DIR"/out/arch/arm64/boot/dtbo.img AnyKernel3/dtbo.img
	fi
	cdir AnyKernel3
	zip -r $ZIPNAME-$DEVICE-"$DATE" . -x ".git*" -x "README.md" -x "*.zip"

	## Prepare a final zip variable
	ZIP_FINAL="$ZIPNAME-$DEVICE-$DATE"

}

clone
exports
build_kernel