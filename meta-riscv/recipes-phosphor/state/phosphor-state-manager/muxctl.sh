#!/bin/sh

if [ "$2" = "" ]
then
        echo "usage: $0 slot action"
        exit 1
fi

set -eu

# just named gpio, no led, :)

s0_high() {
        echo 1 > /sys/class/leds/amber\:muxsel0/brightness
}

s0_low() {
        echo 0 > /sys/class/leds/amber\:muxsel0/brightness
}

s1_high() {
        echo 1 > /sys/class/leds/amber\:muxsel1/brightness
}

s1_low() {
        echo 0 > /sys/class/leds/amber\:muxsel1/brightness
}

s2_high() {
        echo 1 > /sys/class/leds/amber\:muxsel2/brightness
}

s2_low() {
        echo 0 > /sys/class/leds/amber\:muxsel2/brightness
}

rst_high() {
        echo 1 > /sys/class/leds/amber\:rstsel/brightness
}

rst_low() {
        echo 0 > /sys/class/leds/amber\:rstsel/brightness
}

boot_high() {
        echo 1 > /sys/class/leds/amber\:bootsel/brightness
}

boot_low() {
        echo 0 > /sys/class/leds/amber\:bootsel/brightness
}

case "$1" in
        1)
                s0_low; s1_low; s2_low;
                ;;
        2)
                s0_high; s1_low; s2_low;
                ;;
        3)
                s0_low; s1_high; s2_low;
                ;;
        4)
                s0_high; s1_high; s2_low;
                ;;
        5)
                s0_low; s1_low; s2_high;
                ;;
        6)
                s0_high; s1_low; s2_high;
                ;;
        7)
                s0_low; s1_high; s2_high;
                ;;
        *)
                s0_high; s1_high; s2_high;
                echo "unknwon slot"
                ;;
esac

case $2 in
        boot)
                rst_high; sleep 0.5;
                rst_low; sleep 0.5;
                boot_low; sleep 0.5;
                rst_high; sleep 0.5;
                boot_high; sleep 0.5;
                ;;
        reset)
                boot_high; sleep 0.5;
                rst_high; sleep 0.5;
                rst_low; sleep 0.5;
                rst_high; sleep 0.5;
                ;;
        *)
                echo "unknown action"
                ;;
esac

s0_high; s1_high; s2_high;
