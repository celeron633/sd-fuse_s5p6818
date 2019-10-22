#!/bin/bash
set -eu

[ -f ${PWD}/mk-emmc-image.sh ] || {
	echo "Error: please run at the script's home dir"
	exit 1
}

true ${SOC:=s5p6818}
ARCH=arm64
KIMG=arch/${ARCH}/boot/Image
KDTB=arch/${ARCH}/boot/dts/nexell/s5p6818-nanopi3-*.dtb
OUT=${PWD}/out

UBOOT_DIR=$1
KERNEL_DIR=$2
BOOT_DIR=$3
ROOTFS_DIR=$4
PREBUILT=$5

KMODULES_OUTDIR="${OUT}/output_${SOC}_kmodules"

# boot
rsync -a --no-o --no-g ${KERNEL_DIR}/${KIMG} ${BOOT_DIR}
rsync -a --no-o --no-g ${KERNEL_DIR}/${KDTB} ${BOOT_DIR}
rsync -a --no-o --no-g ${PREBUILT}/boot/* ${BOOT_DIR}

# rootfs
rm -rf ${ROOTFS_DIR}/lib/modules/*
cp -af ${KMODULES_OUTDIR}/* ${ROOTFS_DIR}


exit 0