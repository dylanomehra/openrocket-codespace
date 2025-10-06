#!/usr/bin/env bash
set -e

# 1. Download OpenRocket JAR if it doesn't exist
if [ ! -f ~/OpenRocket-24.12.jar ]; then
    wget -O ~/OpenRocket-24.12.jar "https://downloads.sourceforge.net/project/openrocket/openrocket/24.12/OpenRocket-24.12.jar"
    chmod +x ~/OpenRocket-24.12.jar
fi

# 2. Kill any previous instances
pkill -f Xvfb || true
pkill -f x11vnc || true
pkill -f websockify || true

# 3. Start virtual display
export DISPLAY=:1
Xvfb :1 -screen 0 1280x800x24 &

# 4. Start lightweight desktop
startxfce4 &
sleep 5

# 5. Start VNC server
x11vnc -display :1 -nopw -forever -shared -rfbport 5900 &

# 6. Start noVNC proxy on port 8080
websockify --web=/usr/share/novnc/ 8080 localhost:5900 &

# 7. Launch OpenRocket
java -jar ~/OpenRocket-24.12.jar
