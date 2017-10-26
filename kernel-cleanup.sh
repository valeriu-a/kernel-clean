#!/bin/bash

sudo -k

KERNEL_VERS=$(uname -r)
KERNEL_REM_LIST=$(dpkg-query -W -f='${binary:Package}\n' 'linux-image*' | tail -n +2 | grep -v $KERNEL_VERS)

echo -e "The kernel version you are running is $KERNEL_VERS\n."
echo -e "You can remove the following kernel packages:"
echo -e "$KERNEL_REM_LIST\n"

read -p "Do you want to continue? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo apt-get remove $KERNEL_REM_LIST
    sudo apt-get autoremove
    sudo update-grub
    sudo apt-get clean
    sudo apt-get update
fi