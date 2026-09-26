#!/bin/bash

echo "Linux Environment | Launching X Virtual Framebuffer" >> /dos/STDOUT.LOG
Xvfb :99 -screen 0 960x720x24 &
sleep 2

if [ -d "/cache" ] && [ -n "$(ls -A "/cache" 2>/dev/null)" ]; then
    echo "Linux Environment | Cache directory exists and has files; using it" >> /dos/STDOUT.LOG
    cp -r /cache/* /dos/
    touch /dos/SKIPINST.FLG
fi

echo "Linux Environment | Preparing DMX directories" >> /dos/STDOUT.LOG
mkdir /dos/DMX/dmx37
cp -r /dos/DMX/dmx34a/* /dos/DMX/dmx37/
cp -r /dos/DMX/dmx37lib/* /dos/DMX/dmx37/

if [ -n "$VNC_SERVER" ]; then
    echo "Linux Environment | Launching X11 VNC server" >> /dos/STDOUT.LOG
    x11vnc -forever -create -display :99 -nopw &
fi

dosbox &

if [ ! -f /dos/SKIPINST.FLG ]; then
    echo "Linux Environment | Waiting to switch to Watcom C++ 9.5 disk 2" >> /dos/STDOUT.LOG
    sleep 35
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Watcom C++ 9.5 disk 3" >> /dos/STDOUT.LOG
    sleep 8
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Watcom C++ 9.5 disk 4" >> /dos/STDOUT.LOG
    sleep 8
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Watcom C++ 9.5 disk 5" >> /dos/STDOUT.LOG
    sleep 8
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Watcom C++ 9.5 disk 6" >> /dos/STDOUT.LOG
    sleep 8
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Watcom C++ 9.5 disk 7" >> /dos/STDOUT.LOG
    sleep 8
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Watcom C++ 9.5 disk 8" >> /dos/STDOUT.LOG
    sleep 8
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return

    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 2" >> /dos/STDOUT.LOG
    sleep 50
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 3" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 4" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 5" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 6" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 7" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 8" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 9" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 10" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 11" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 12" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 13" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 14" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to switch to Borland C++ 3.1 disk 15" >> /dos/STDOUT.LOG
    sleep 2
    DISPLAY=:99 xdotool key ctrl+F4
    DISPLAY=:99 xdotool key Return
    echo "Linux Environment | Waiting to exit Borland C++ 3.1 installation" >> /dos/STDOUT.LOG
    sleep 4
    DISPLAY=:99 xdotool key Return
    DISPLAY=:99 xdotool key Escape
fi

echo "Linux Environment | Waiting for the Doom build to compelete" >> /dos/STDOUT.LOG
sleep 200

if [ -d "/cache" ] && [ -z "$(ls -A "/cache")" ]; then
    echo "Linux Environment | Cache directory exists and is empty; caching Watcom C++ and TASM installs" >> /dos/STDOUT.LOG
    mkdir /cache/BORLANDC/
    cp -r /dos/BORLANDC/* /cache/BORLANDC/
    mkdir /cache/WATCOM/
    cp -r /dos/WATCOM/* /cache/WATCOM/
fi

echo "Linux Environment | Copying compiled binary to /dosbin" >> /dos/STDOUT.LOG
mkdir /dosbin
cp /dos/SRC/DM19/STRPDOOM.LE /dosbin/'doom v1.9 (stripped).le'

sleep 3600
