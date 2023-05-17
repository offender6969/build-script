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
        echo "Skiping..."
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
        echo "skiping..."
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
echo "6. AOSP Clang"
echo "7. skip"

read -p "Enter your choice (1/2/3/4/5/6): " clang_choice

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
        git clone https://gitlab.com/GhosutoX/aosp-clang-17.git -b 17 prebuilts/clang/host/linux-x86/clang-aosp
        ;;
    6)
        echo "Cloning AOSP Clang..."
        git clone https://gitlab.com/jjpprrrr/prelude-clang.git prebuilts/clang/host/linux-x86/clang-pre
        ;;
    *)
        echo "skiping..."
        ;;
esac

echo "Clang Cloning complete."





#!/bin/bash

echo "Want to remove old kernel:"
echo "1. yes"
echo "2. no"

read -p "Enter your choice (1/2): " kernel_remove_choice

case $kernel_remove_choice in
     1)   
        echo "Removing kernel "
        rm -rf kernel/xiaomi/alioth
        
        echo " kernel remove complete."
        ;;
     2)
        echo "Skiping..."
        ;;
esac


# Get user input for kernel choice

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
        echo "Skiping..."
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
esac


#!/bin/bash

# Prompt for GCAM input
echo "Want to clone gcam:"
echo "1. yes"
echo "2. no"

read -p "Do you want to clone GCam? (1/2): " GCAM

# Cloning GCam if GCAM variable is set to "1"

case $GCAM in
     1)
         echo "Cloning GCam"
         git clone https://gitlab.com/Alioth-Project/vendor_GcamBSG.git -b twelve vendor/GcamBSG
         ;;
     2)
         echo "Skipping GCam"
         ;;
esac


# Prompt for LEICA input
echo "Want to clone LEICA:"
echo "1. yes"
echo "2. no"

read -p "Do you want to clone GCam? (1/2): " LEICA

# Cloning GCam if GCAM variable is set to "1"

case $LEICA in
     1)
         echo "Cloning MIUI Camera"
         git clone https://gitlab.com/dark.phnx12/android_vendor_xiaomi_alioth-miuicamera.git vendor/xiaomi/alioth-miuicamera
         ;;

     2)
         echo "Skipping GCam"
         ;;
esac



# Prompt for GHOSTICON input
echo "Want to clone GHOSTICON:"
echo "1. yes"
echo "2. no"

read -p "Do you want to clone GHOSTICON? (1/2): " GHOSTICON

# Cloning GCam if GCAM variable is set to "1"

case $GHOSTICON in
     1)
         echo "Cloning GHOSTICON"
         git clone https://github.com/Ghosuto/vendor_ghosticon.git vendor/ghosticon
         ;;

     2)
         echo "Skipping GCam"
         ;;
esac


cd vendor/xiaomi/alioth-miuicamera
echo "entered miuicamera dir"


# prompt user for confirmation
read -p "Are you sure you want to revert 48mp commit? [y/n] " choice

if [[ $choice == "y" ]]; then
  # revert the commit
  git revert 8e0541d4114508731c3c2a1eda9b080284b0a182

  echo "Commit reverted successfully."
else
  echo "Commit was not reverted."
fi
