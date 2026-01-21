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
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

# Create a symlink for consistency (Selenium expects /usr/bin/google-chrome)
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome

# Switch back to the default notebook user
USER jovyan

# Install Python packages
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt
