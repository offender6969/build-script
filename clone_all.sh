## Script For cloning DT and hals
#put this clone.sh file in rom dir then execute

#put "yes" if you want to clone, put "no" if you don't want 

#Tree
TREE=no

#Choose kernel
KERNEL=n0
#default n0, other option immensity, redline, infinir, nexus

#Choose clang
CLANG=weebx
#default weebx, other options zyc, sd, proton, aosp

#Gcam
GCAM=no

#miui camera
LEICA=no

#--------do not change anything--------#

#Device tree and vendor
       if [ "${TREE}" = "yes" ]; then
		echo "cloning device tree and vendor"
git clone https://github.com/Ghosuto/device_xiaomi_alioth.git -b 13.0 device/xiaomi/alioth
git clone https://github.com/Ghosuto/device_xiaomi_sm8250-common.git -b 13.0 device/xiaomi/sm8250-common
git clone https://github.com/Ghosuto/android_vendor_xiaomi_alioth.git -b 13.0 vendor/xiaomi/alioth
git clone https://github.com/Ghosuto/android_vendor_xiaomi_sm8250-common.git -b 13.0 vendor/xiaomi/sm8250-common
       elif [ "${TREE}" = "no" ]; then
       echo "CLONE YOUR TREE AND VENDOR"
       fi
      

#kernel
echo "cloning kernel"
		if [ "${KERNEL}" = "n0" ]; then
		echo "cloning N0 kernel"
			git clone --depth=1 https://github.com/EmanuelCN/kernel_xiaomi_sm8250 -b staging kernel/xiaomi/alioth
        elif [ "${KERNEL}" = "immensity" ]; then
        echo "cloning Immensity kernel"
			git clone https://github.com/UtsavBalar1231/kernel_xiaomi_sm8250 -b android12-next kernel/xiaomi/alioth
		elif [ "${KERNEL}" = "redline" ]; then
		echo "cloning Redline kernel"
			git clone https://github.com/VoidUI-Devices/kernel_xiaomi_sm8250 -b aosp-13 kernel/xiaomi/alioth
		elif [ "${KERNEL}" = "nexus" ]; then
		echo "cloning nexus kernel"
		    git clone https://github.com/projects-nexus/nexus_kernel_xiaomi_sm8250 -b staging kernel/xiaomi/alioth
		elif [ "${KERNEL}" = "infinir" ]; then
		echo "cloning infinir kernel"
		    git clone https://github.com/raystef66/InfiniR_kernel_alioth -b 13.0-alioth kernel/xiaomi/alioth
		fi

#Clang
echo "cloning clang"
		if [ "${CLANG}" = "proton" ]; then
		echo "proton"
			git clone https://github.com/kdrag0n/proton-clang.git prebuilts/clang/host/linux-x86/clang-proton
        elif [ "${CLANG}" = "sd" ]; then
        echo "sd"
			git clone https://gitlab.com/VoidUI/snapdragon-clang.git prebuilts/clang/host/linux-x86/clang-sd
		elif [ "${CLANG}" = "zyc" ]; then
		echo "zyc"
			git clone https://gitlab.com/GhosutoX/zyc-clang16.git prebuilts/clang/host/linux-x86/clang-zyc
		elif [ "${CLANG}" = "weebx" ]; then
		echo "weebx"
		    git clone https://gitlab.com/GhosutoX/weebx-clang16.git prebuilts/clang/host/linux-x86/clang-weebx
		elif [ "${CLANG}" = "aosp" ]; then
		echo "aosp"
		    git clone --depth=1 https://gitlab.com/GhosutoX/aosp-clang-17.0.0.git prebuilts/clang/host/linux-x86/clang-aosp
		fi
		
#hals
rm -rf hardware/xiaomi && git clone https://github.com/Ghosuto/hardware_xiaomi.git hardware/xiaomi
rm -rf hardware/qcom-caf/sm8250/display && git clone https://github.com/Ghosuto/hardware_qcom-caf_sm8250_display.git -b aosp-13 hardware/qcom-caf/sm8250/display
rm -rf hardware/qcom-caf/sm8250/media && git clone https://github.com/Ghosuto/hardware_qcom-caf_sm8250_media.git -b aosp-13 hardware/qcom-caf/sm8250/media 
rm -rf hardware/qcom-caf/sm8250/audio && git clone https://github.com/Ghosuto/hardware_qcom-caf_sm8250_audio.git -b aosp-13 hardware/qcom-caf/sm8250/audio 
rm -rf vendor/qcom/opensource/power && git clone https://github.com/Ghosuto/vendor_qcom_opensource_power.git vendor/qcom/opensource/power
rm -rf vendor/qcom/opensource/interfaces &&  git clone https://github.com/Ghosuto/vendor_qcom_opensource_interfaces.git -b aosp-13 vendor/qcom/opensource/interfaces
rm -rf hardware/qcom-caf/bootctrl && git clone https://github.com/drkphnx/hardware_qcom-caf_bootctrl.git -b aosp-13 hardware/qcom-caf/bootctrl
rm -rf external/ant-wireless/antradio-library && git clone https://github.com/drkphnx/external_ant-wireless_antradio-library -b snowcone external/ant-wireless/antradio-library

#Gcam
       if [ "${GCAM}" = "yes" ]; then
 git clone https://gitlab.com/Alioth-Project/vendor_GcamBSG.git -b twelve vendor/GcamBSG
 elif [ "${GCAM}" = "no" ]; then
       echo "skip GCAM"
       fi

#MIUI CAMERA
       if [ "${LEICA}" = "yes" ]; then
  git clone https://gitlab.com/dark.phnx12/android_vendor_xiaomi_alioth-miuicamera.git vendor/xiaomi/alioth-miuicamera
       elif [ "${LEICA}" = "no" ]; then
       echo "skip MIUI CAMERA"
       fi

