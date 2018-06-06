#!/bin/bash
# used to disable swipe for kubeadm
# https://www.refmanual.com/2016/01/08/completely-remove-swap-on-ce7
# It is very dangerous to run this script.
# Do not run it on any other platform except centos7 and do not run it on virtual machine
#
exists_test=$(free | grep Swap | awk '{print $2}')
if [ "$exists_test" = "0" ]; then
    echo swap is already disable
    exit
fi

echo begin disable swap

swapoff -a
echo begin remove logical volumes
lv_swap_path=$(lvdisplay | grep swap | grep Path | awk '{print $3}')
if ! [ -z "$lv_swap_path" ]; then
    yes | lvremove -Ay ${lv_swap_path}
    lvextend -l +100%FREE /dev/centos/data
    cp /etc/default/grub /etc/default/grub.bak
    sed -i "s/rd.lvm.lv=centos\/swap//g" /etc/default/grub

    echo begin change fstab
    # remove fstab
    cp /etc/fstab /etc/fstab.bak
    sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

    echo begin chage grub
    cp /etc/grub2.cfg /etc/grub2.cfg.bak
    grub2-mkconfig >/etc/grub2.cfg
fi
