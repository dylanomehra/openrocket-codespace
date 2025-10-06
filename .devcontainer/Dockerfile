FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
USER root

# Install Java + GUI dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk wget curl git ca-certificates \
    xvfb xfce4 x11vnc \
    supervisor novnc websockify python3 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user (Codespaces uses 'vscode')
ARG USERNAME=vscode
RUN useradd -ms /bin/bash $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME
