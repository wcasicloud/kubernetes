#!/bin/bash
#
# disable swap on virtual machine
#
#
swapoff -a
sed -i 's/.*swap.*/#&/' /etc/fstab
