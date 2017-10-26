#!/bin/bash

sudo -k

KERNEL_VERS=$(uname -r)
KERNEL_REM_LIST=$(dpkg --list 'linux-image*' | awk '{ if ($1=="ii") print $2}' | grep -v '$KERNEL_VERS')

echo -e "\nThe kernel version you are running is '$KERNEL_VERS'.\n"

if [ -z "$KERNEL_REM_LIST" ]
  then
        echo -e "No kernel packages to remove.\n" && exit
else
        echo -e "You can remove the following kernel packages:"
        echo -e "$KERNEL_REM_LIST\n"
fi

read -p "Do you want to continue? (Y or N - default is N)  " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo apt-get --yes purge $KERNEL_REM_LIST
    sudo apt-get --yes autoremove
    sudo update-grub
    sudo apt-get --yes clean
    sudo apt-get update
  else
    echo -e "\n\nbye bye\n"
fi
