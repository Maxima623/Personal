#! /bin/sh

if [ -e /sys/module/drm ]; then
	wget -qP /etc/modprobe.d - https://raw.githubusercontent.com/Maxima623/Personal/master/Modprobe/99_drm.conf
fi

if [ -e /sys/module/i915 ]; then
	wget -qP /etc/modprobe.d - https://raw.githubusercontent.com/Maxima623/Personal/master/Modprobe/99_i915.conf
fi

if [ -e /sys/module/iwlwifi ]; then
	wget -qP /etc/modprobe.d - https://raw.githubusercontent.com/Maxima623/Personal/master/Modprobe/99_iwlwifi.conf
fi

exit 0
