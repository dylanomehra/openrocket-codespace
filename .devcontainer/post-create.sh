#!/usr/bin/env bash
set -e
cd "$HOME"

# Download OpenRocket JAR (latest stable version)
OR_VERSION="24.12"
OR_JAR="OpenRocket-${OR_VERSION}.jar"

# Grab the JAR file
wget -O "$HOME/$OR_JAR" "https://openrocket.info/downloads/${OR_JAR}" || true
chmod +x "$HOME/$OR_JAR"

echo "✅ OpenRocket $OR_VERSION downloaded."

# Clone noVNC (used to view GUI in browser)
if [ ! -d "$HOME/noVNC" ]; then
  git clone https://github.com/novnc/noVNC.git
  git clone https://github.com/novnc/websockify.git noVNC/utils/websockify
fi

echo "✅ noVNC setup complete."
echo "Run this after the container is ready: bash .devcontainer/start-openrocket.sh"
