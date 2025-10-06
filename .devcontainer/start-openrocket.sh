#!/usr/bin/env bash
set -e

# 1️⃣ Download OpenRocket if missing
if [ ! -f ~/OpenRocket-24.12.jar ]; then
    wget -O ~/OpenRocket-24.12.jar "https://downloads.sourceforge.net/project/openrocket/openrocket/24.12/OpenRocket-24.12.jar"
    chmod +x ~/OpenRocket-24.12.jar
fi

# 2️⃣ Kill any previous instances
pkill -f Xvfb || true
pkill -f x11vnc || true
pkill -f websockify || true

# 3️⃣ Start virtual display
export DISPLAY=:1
Xvfb :1 -screen 0 1280x800x24 &

# 4️⃣ Start lightweight desktop
startxfce4 &
sleep 5

# 5️⃣ Start VNC server
x11vnc -display :1 -nopw -forever -shared -rfbport 5900 &

# 6️⃣ Start noVNC proxy on port 8080
websockify --web=/usr/share/novnc/ 8080 localhost:5900 &

# 7️⃣ Launch OpenRocket
java -jar ~/OpenRocket-24.12.jar &

# 8️⃣ Automatically open vnc.html in browser
sleep 3
BROWSER_URL="vnc.html"
if command -v xdg-open &>/dev/null; then
    xdg-open "http://localhost:8080/$BROWSER_URL" || true
fi

echo "🌐 OpenRocket should now be running. If not, open this URL in your browser:"
echo "http://localhost:8080/$BROWSER_URL"
