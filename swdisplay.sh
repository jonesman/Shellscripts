#!/bin/bash

DISPLAY_INT="eDP-1"
DISPLAY_INT_RES="1920x1080"

DISPLAY_EXT="HDMI-1"
DISPLAY_EXT_RES="1920x1080"
DISPLAY_EXT_POSI="right"

XRANDR="/usr/bin/xrandr"

function enable_int() {
	$XRANDR --output "$DISPLAY_INT" --auto
	$XRANDR --output "$DISPLAY_INT" --mode $DISPLAY_INT_RES
}

function enable_ext() {

	POSI_PARAM=""
	case $DISPLAY_EXT_POSI in
		left)
			POSI_PARAM="--left-of"
		;;
		above)
			POSI_PARAM="--above"
		;;
		right)
			POSI_PARAM="--right-of"
		;;
		below)
			POSI_PARAM="--below"
		;;
	esac

	$XRANDR --output "$DISPLAY_EXT" --auto $POSI_PARAM "$DISPLAY_INT" 
	$XRANDR --output "$DISPLAY_EXT" --mode "$DISPLAY_EXT_RES"

}

function enable_ext_single() {
	$XRANDR --output "$DISPLAY_EXT" --auto
	$XRANDR --output "$DISPLAY_EXT" --mode $DISPLAY_EXT_RES
}

function disable_display() {
	$XRANDR --output "$1" --off
}

echo -e "\n1. Internal + External"
echo "2. Only Internal"
echo -e "3. Only External\n"

read -p "Select: " sel

case "$sel" in

	1)
		enable_int
		enable_ext
	;;

	2)
		disable_display "$DISPLAY_EXT"
		enable_int
	;;

	3)
		disable_display "$DISPLAY_INT"
		enable_ext_single
	;;

esac
