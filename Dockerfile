FROM beevelop/cordova
    
# Installs Other tools
RUN npm install -g grunt-cli && \
    npm install -g bower && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    apt-get update && \
    apt-get install -y subversion && \
    apt-get install -y git && \
    apt-get install -y vim

COPY init.sh /data/init.sh
RUN chmod +x /data/init.sh

COPY build.sh /data/build.sh
RUN chmod +x /data/build.sh

VOLUME ["/data"]
WORKDIR /data

EXPOSE 8000
