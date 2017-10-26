#!/bin/bash

sudo -k

KERNEL_VERS=$(uname -r)
KERNEL_REM_LIST=$(rpm -q kernel | grep -v 'kernel-$KERNEL_VERS')

echo -e "\nThe kernel version you are running is kernel-$KERNEL_VERS.\n"

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
    yum -y install yum-utils
    package-cleanup --oldkernels --count=1
  else
    echo -e "\n\nbye bye\n"
fi
