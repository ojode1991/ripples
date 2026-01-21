# Use a Binder-compatible base image
FROM jupyter/base-notebook:latest

# Switch to root for installations (allowed during build)
USER root

# Update and install system dependencies (including Tor)
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    tor \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome (stable)
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the default notebook user
USER jovyan

# Install Python packages
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt
