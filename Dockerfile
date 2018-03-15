FROM node:8
# Install global denpendencies
RUN npm install pm2 -g --registry=https://registry.npm.taobao.org && \
    npm config set registry https://registry.npm.taobao.org && \
    npm install -g cnpm

# Create app directory
WORKDIR /opt/app
