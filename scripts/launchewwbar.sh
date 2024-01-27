#!/bin/bash

#kill eww 
killall -q eww

#wait until the processes have been shut down
while pgrep -u $UID -x eww >/dev/null; do sleep 1; done

#launch eww bar from ~/repos/eww/target/release/ and exec eww bar
~/repos/eww/target/release/eww open bar &

