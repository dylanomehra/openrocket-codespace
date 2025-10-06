FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Java, GUI, and VNC tools
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk wget xvfb xfce4 xfce4-goodies x11vnc novnc websockify git curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /home/vscode
