#!/bin/sh

GPIO_SYSFS=/sys/class/gpio/
echo 208 > ${GPIO_SYSFS}/export
echo out > ${GPIO_SYSFS}/gpio208/direction
echo 209 > ${GPIO_SYSFS}/export
echo out > ${GPIO_SYSFS}/gpio209/direction

boot_high() {
	echo 1 > ${GPIO_SYSFS}/gpio208/value
}
boot_low() {
	echo 0 > ${GPIO_SYSFS}/gpio208/value
}

rst_high() {
	echo 1 > ${GPIO_SYSFS}/gpio209/value
}

rst_low() {
	echo 0 > ${GPIO_SYSFS}/gpio209/value
}

boot_high
rst_high
rst_low
rst_high
sleep 3
blisp iot -c bl70x -p /dev/ttyACM0 -s $(dirname $(realpath $0))/bl702_dualuart_whole_img.bin -s 0x0
boot_low
rst_high
rst_low
rst_high
sleep 5
ls /dev/ttyACM0
ls /dev/ttyACM1
