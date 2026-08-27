#!/bin/sh
bspc subscribe node_geometry | while read -r _ _ _ id _rest; do
    class=$(xdotool getwindowclassname "$id" 2>/dev/null)
    case "$class" in
        TelegramDesktop)
            wmctrl -ir "$id" -e 0,2,32,550,1164
            ;;
        vesktop)
            wmctrl -ir "$id" -e 0,554,32,1364,1164
            ;;
    esac
done
