# Function to clone a repository with username and personal access token
clone_repo() {
    local repo_url=$1
    local repo_path=$2
    local repo_name=$3
    read -p "Enter username for $repo_name: " username
    read -s -p "Enter personal access token for $repo_name: " access_token
    echo ""
    if [ ! -d "$repo_path" ]; then
        echo "Cloning $repo_name..."
        git clone "$repo_url" "$repo_path" <<< "$username:$access_token"
    else
        echo "Skipping cloning for $repo_name as it already exists."
    fi
}




#!/bin/bash

# Get user input for Tree and vendor choice
echo "Want to remove old tree and vendor:"
echo "1. yes"
echo "2. no"

read -p "Enter your choice (1/2): " tree_remove_choice

case $tree_remove_choice in
     1)   
        echo "Removing Tree and vendor "
        rm -rf device/xiaomi/alioth && rm -rf device/xiaomi/sm8250-common && rm -rf vendor/xiaomi/alioth && rm -rf vendor/xiaomi/sm8250-common
        
        echo " Tree remove complete."
        ;;
     2)
        echo "Invalid choice. Exiting..."
        ;;
esac


# Get user input for Tree and vendor choice
echo "Want to clone tree and vendor:"
echo "1. yes"
echo "2. no"

read -p "Enter your choice (1/2): " tree_choice

case $tree_choice in
    1)
        # Clone device tree for alioth
        echo "Cloning device_xiaomi_alioth..."
        git clone https://github.com/Ghosuto/device_xiaomi_alioth.git device/xiaomi/alioth

        # Clone device_common repository
        echo "Cloning device_xiaomi_sm8250-common..."
        git clone https://github.com/Ghosuto/device_xiaomi_sm8250-common.git device/xiaomi/sm8250-common

        # Clone device_vendor repository
        echo "Cloning android_vendor_xiaomi_sm8250-common..."
        git clone https://github.com/Ghosuto/android_vendor_xiaomi_alioth.git vendor/xiaomi/alioth

        # Clone device_common_vendor repository
        echo "Cloning android_vendor_xiaomi_alioth..."
        git clone https://github.com/Ghosuto/android_vendor_xiaomi_sm8250-common.git vendor/xiaomi/sm8250-common

        echo " Tree Cloning complete."
        ;;
    2)
        echo "Invalid choice. Exiting..."
        ;;
        
             
esac




#!/bin/bash

# Get user input for Clang choice
echo "Please select which Clang compiler repository to clone:"
echo "1. Proton Clang"
echo "2. Snapdragon Clang"
echo "3. Zyc Clang"
echo "4. Weebx Clang"
echo "5. AOSP Clang"

read -p "Enter your choice (1/2/3/4/5): " clang_choice

case $clang_choice in
    1)
        echo "Cloning Proton Clang..."
        git clone https://github.com/kdrag0n/proton-clang.git prebuilts/clang/host/linux-x86/clang-proton
        ;;
    2)
        echo "Cloning Snapdragon Clang..."
        git clone https://gitlab.com/VoidUI/snapdragon-clang.git prebuilts/clang/host/linux-x86/clang-sd
        ;;
    3)
        echo "Cloning Zyc Clang..."
        git clone https://gitlab.com/GhosutoX/zyc-clang16.git prebuilts/clang/host/linux-x86/clang-zyc
        ;;
    4)
        echo "Cloning Weebx Clang..."
        git clone https://gitlab.com/GhosutoX/weebx-clang16.git prebuilts/clang/host/linux-x86/clang-weebx
        ;;
    5)
        echo "Cloning AOSP Clang..."
        git clone --depth=1 https://gitlab.com/GhosutoX/aosp-clang-17.0.0.git prebuilts/clang/host/linux-x86/clang-aosp
        ;;
    *)
        echo "Invalid choice. Exiting..."
        ;;
esac

echo "Clang Cloning complete."





#!/bin/bash

# Get user input for kernel choice

kernel_dir="kernel/xiaomi/alioth"

if [ -d "$kernel_dir" ]; then
    read -p "The kernel directory already exists. Do you want to remove it? (Y/N): " response
    if [ "${response,,}" = "y" ]; then
        rm -rf "$kernel_dir"
        echo "kernel directory removed."
    else
        echo "remove aborted."
    fi
else
    echo kernel directory does not exist."
fi

echo "Please select which kernel repository to clone:"
echo "1. N0 kernel"
echo "2. Immensity kernel"
echo "3. Redline kernel"
echo "4. Nexus kernel"
echo "5. InfiniR kernel"
echo "6. N0 kernel Ghost edition"

read -p "Enter your choice (1/2/3/4/5/6): " kernel_choice

case $kernel_choice in
    1)
        echo "Cloning N0 kernel..."
        git clone --depth=1 https://github.com/EmanuelCN/kernel_xiaomi_sm8250 -b staging kernel/xiaomi/alioth
        ;;
    2)
        echo "Cloning Immensity kernel..."
        git clone https://github.com/UtsavBalar1231/kernel_xiaomi_sm8250 -b android12-next kernel/xiaomi/alioth
        ;;
    3)
        echo "Cloning Redline kernel..."
        git clone https://github.com/VoidUI-Devices/kernel_xiaomi_sm8250 -b aosp-13 kernel/xiaomi/alioth
        ;;
    4)
        echo "Cloning Nexus kernel..."
        git clone https://github.com/projects-nexus/nexus_kernel_xiaomi_sm8250 -b staging kernel/xiaomi/alioth
        ;;
    5)
        echo "Cloning InfiniR kernel..."
        git clone https://github.com/raystef66/InfiniR_kernel_alioth -b 13.0-alioth kernel/xiaomi/alioth
        ;;
    6)
        echo "Cloning N0 GhostEdition kernel..."
        git clone https://github.com/Ghosuto/kernel_xiaomi_sm8250.git -b staging kernel/xiaomi/alioth
        ;;
    *)
        echo "Invalid choice. Exiting..."
        ;;
esac

echo " Kernel Cloning complete."




#!/bin/bash

# Get user input for hals choice
echo "Want to remove stock hals and use custom hals:"
echo "1. yes"
echo "2. no"

read -p "Enter your choice (1/2): " clone_hals

case $clone_hals in
     1)
        echo "Cloning hardware/xiaomi..."
        rm -rf hardware/xiaomi
        git clone https://github.com/Ghosuto/hardware_xiaomi.git -b aosp-13 hardware/xiaomi

        echo "Cloning hardware/qcom-caf/sm8250/display..."
        rm -rf hardware/qcom-caf/sm8250/display
        git clone https://github.com/Ghosuto/hardware_qcom-caf_sm8250_display.git -b aosp-13 hardware/qcom-caf/sm8250/display

        echo "Cloning hardware/qcom-caf/sm8250/media..."
        rm -rf hardware/qcom-caf/sm8250/media
        git clone https://github.com/Ghosuto/hardware_qcom-caf_sm8250_media.git -b aosp-13 hardware/qcom-caf/sm8250/media

        echo "Cloning hardware/qcom-caf/sm8250/audio..."
        rm -rf hardware/qcom-caf/sm8250/audio
        git clone https://github.com/Ghosuto/hardware_qcom-caf_sm8250_audio.git -b aosp-13 hardware/qcom-caf/sm8250/audio

        echo "Cloning vendor/qcom/opensource/power..."
        rm -rf vendor/qcom/opensource/power
        git clone https://github.com/Ghosuto/vendor_qcom_opensource_power.git vendor/qcom/opensource/power

        echo "Cloning vendor/qcom/opensource/interfaces..."
        rm -rf vendor/qcom/opensource/interfaces
        git clone https://github.com/Ghosuto/vendor_qcom_opensource_interfaces.git -b aosp-13 vendor/qcom/opensource/interfaces

        echo "Cloning hardware/qcom-caf/bootctrl..."
        rm -rf hardware/qcom-caf/bootctrl
        git clone https://github.com/drkphnx/hardware_qcom-caf_bootctrl.git -b aosp-13 hardware/qcom-caf/bootctrl

        echo "Cloning external/ant-wireless/antradio-library..."
        rm -rf external/ant-wireless/antradio-library
        git clone https://github.com/drkphnx/external_ant-wireless_antradio-library -b snowcone external/ant-wireless/antradio-library

        echo " Hals Cloning complete."
        ;;

      2)
        echo "Using stock hals..."
        ;;



#!/bin/bash

# Prompt for GCAM input
read -p "Do you want to clone GCam? (yes/no): " GCAM

# Cloning GCam if GCAM variable is set to "yes"
if [ "${GCAM}" = "yes" ]; then
    echo "Cloning GCam"
    git clone https://gitlab.com/Alioth-Project/vendor_GcamBSG.git -b twelve vendor/GcamBSG
elif [ "${GCAM}" = "no" ]; then
    echo "Skipping GCam"
fi

# Prompt for LEICA input
read -p "Do you want to clone MIUI Camera? (yes/no): " LEICA

# Cloning MIUI Camera if LEICA variable is set to "yes"
if [ "${LEICA}" = "yes" ]; then
    echo "Cloning MIUI Camera"
    git clone https://gitlab.com/dark.phnx12/android_vendor_xiaomi_alioth-miuicamera.git vendor/xiaomi/alioth-miuicamera
elif [ "${LEICA}" = "no" ]; then
    echo "Skipping MIUI Camera"
fi




# Prompt for GHOSTICON input
read -p "Do you want to clone GHOSTICON? (yes/no): " GHOSTICON

# Cloning GHOSTICON if GHOSTICON variable is set to "yes"
if [ "${GHOSTICON}" = "yes" ]; then
    echo "Cloning GCam"
    git clone https://github.com/Ghosuto/vendor_ghosticon.git vendor/ghosticon
elif [ "${GHOSTICON}" = "no" ]; then
    echo "Skipping GHOSTICON"
fi
