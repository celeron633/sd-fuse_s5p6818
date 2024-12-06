#!/bin/bash

function usage()
{
	echo "usage:"
	echo "$0 <blk_device>"
	exit 0
}

cp ../u-boot_gec6818/fip-nonsecure.img ./prebuilt/fip-nonsecure.im
target_blk_dev=$1
if [ "_$target_blk_dev" == "_" ];
then
	usage
fi

read -p "target device: ${target_blk_dev}, press y to continue:" confirm
if [ "_${confirm}" == "_y" ];
then
	if ! test -b /dev/${target_blk_dev};
	then
		echo "/dev/${target_blk_dev} is not a block device!"
		exit -1
	fi
	sudo dd if=./prebuilt/fip-nonsecure.img of=/dev/${target_blk_dev} bs=512 seek=3841
	echo "done!"
else
	echo "cancel"
	exit 0
fi
