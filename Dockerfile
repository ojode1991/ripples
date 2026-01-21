FROM jupyter/base-notebook:python-3.10

USER root

# Install Google Chrome, Tor, and dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    tor \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix permissions for the notebook user
USER ${NB_USER}

# Install Python requirements
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt
