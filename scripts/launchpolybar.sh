#!/bin/bash

#kill polybar
killall -q polybar

#wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#launch polybar with ~/.config/polybar/config.ini
polybar topbar &

