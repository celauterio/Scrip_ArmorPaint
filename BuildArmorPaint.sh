#!/bin/bash

#This script follows the instructions from https://github.com/armory3d/armorpaint such as they were at the time of its creation (2019; 06,21). By running this script you accept full responsibility to any actions it takes. Weather or not it works is entirely dependent on your system, and on the developer of ArmorPaint. I am not the creator of ArmorPaint. This script was written with Ubuntu Linux (18) in mind. If your system is something else, it may very well not work.

#IF YOU ARE TRYING TO RUN THIS SCRIPT, AND ENDED UP READING THIS: You need to set the file as an executable. Right click on the file, select "properties", and check the "allow executing file as program" box in the "Permissions" tab. Or else, try draggin the file in a terminal window.

File=~/armorpaint

#clang
 sudo dnf install clang -y

#node.js and git dependencies
 sudo dnf install nodejs -y
 sudo dnf install git -y

#deps (https://github.com/Kode/Kha/wiki/Linux)
sudo dnf install  make clang libXinerama-devel libXrandr-devel alsa-lib-devel libXi-devel mesa-libGL-devel libXcursor-devel vulkan-devel gtk3-devel libstdc++-static libudev-devel -y

#move to install directory
cd ~

if [ -d "$File" ]; then
	echo "$File already exist"
	echo "Updating clone..."
	cd $File
	git pull
	cd ~
else
	echo "$File does not exist"
	git clone --recursive https://github.com/armory3d/armorpaint
fi

#browse to cloned repository on hard drive, and make Krom
cd armorpaint
#node Kha/make krom -g opengl --shaderversion 330
node armorcore/make -g opengl
cd armorcore
node Kinc/make -g opengl --compiler clang --compile
cd Deployment
strip Krom
./Krom ../../build/krom

#Use Krom to make/build ArmorPaint
cd Krom
node Kore/make -g opengl --compiler clang --compile
cd Deployment
strip Krom
#Run ArmorPaint
./Krom ../../build/krom
