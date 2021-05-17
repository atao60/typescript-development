ARG IMG_VERSION=16.1.0
ARG IMG_REPO=atao60
ARG IMG_NAME=node-alpine

FROM $IMG_REPO/$IMG_NAME:$IMG_VERSION

RUN npm install --global typescript && \
    npm install --global ts-node && \
    npm install --global tslint && \
    npm install --global eslint && \
    npm install --global @types/core-js @types/babel-types && \
    npm install --global @typescript-eslint/eslint-plugin @typescript-eslint/parser && \
    npm install --global babel-plugin-module-resolver babel-plugin-node-source-map-support babel-plugin-transform-typescript-metadata && \
    npm install --global eslint-config-node && \
    mkdir -p /app

WORKDIR /app
