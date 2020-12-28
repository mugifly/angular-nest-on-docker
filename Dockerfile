FROM node:14-slim

WORKDIR /opt/app/

EXPOSE 4200

RUN echo "Installing packages..." && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends --quiet \
        curl procps && \
    echo "packages installed." || exit 1 && \
    apt-get clean

COPY lerna.json package.json ./
COPY packages/client/package.json ./packages/client/
COPY packages/server/package.json ./packages/server/

RUN echo "Installing npm modules..." && \
    npm install || exit 1 && \
    npm run postinstall || exit 1 && \
    echo "npm modules installed." && \
    npm cache clean --force

COPY . /opt/app/

CMD ["npm", "start"]