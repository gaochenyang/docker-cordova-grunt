FROM webratio/nodejs-with-android-sdk

# Installs Cordova
# Forces a platform add in order to preload libraries
ENV CORDOVA_VERSION 6.0.0
RUN npm install -g npm && \
    npm install -g cordova@${CORDOVA_VERSION} && \
    cd /tmp && \
    cordova create fakeapp && \
    cd /tmp/fakeapp && \
    cordova platform add android && \
    cd && \
    rm -rf /tmp/fakeapp
    
# Installs Other tools
RUN npm install -g grunt-cli && \
    npm install -g bower && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    apt-get update && \
    apt-get install -y subversion

VOLUME ["/data"]
WORKDIR /data

EXPOSE 8000
