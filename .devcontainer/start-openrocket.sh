#!/usr/bin/env bash
set -e
cd "$HOME"

export DISPLAY=:1
OR_JAR=$(ls OpenRocket-*.jar | head -n 1)

# Start virtual display
Xvfb :1 -screen 0 1280x800x24 &>/tmp/xvfb.log &

# Start a minimal desktop session
startxfce4 &>/tmp/xfce.log &
sleep 2

# Start VNC and noVNC servers
x11vnc -display :1 -nopw -forever -quiet -rfbport 5900 &>/tmp/x11vnc.log &
$HOME/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 8080 &>/tmp/novnc.log &

sleep 3
echo "🌐 noVNC running — check the Ports tab in Codespaces for port 8080."

# Launch OpenRocket
java --add-exports=java.base/java.lang=ALL-UNNAMED \
     --add-exports=java.desktop/sun.awt=ALL-UNNAMED \
     --add-exports=java.desktop/sun.java2d=ALL-UNNAMED \
     -jar "$OR_JAR"
