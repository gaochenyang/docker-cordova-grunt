FROM beevelop/cordova
    
# Installs Other tools
RUN npm install -g grunt-cli && \
    npm install -g bower && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    apt-get update && \
    apt-get install -y subversion && \
    apt-get install -y git

VOLUME ["/data"]
WORKDIR /data

EXPOSE 8000
