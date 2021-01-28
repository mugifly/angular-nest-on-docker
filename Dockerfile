
FROM openapitools/openapi-generator-cli AS build-openapi-generator


FROM node:14-slim

WORKDIR /opt/app/

EXPOSE 4200

# Install apt packages
ARG NODE_ENV="production"
ENV NODE_ENV "${NODE_ENV}"
ARG TEST_CHROMIUM_REVISION="848009"
RUN echo "Installing packages..." && \
    export DEBIAN_FRONTEND="noninteractive" && \
    mkdir -p /usr/share/man/man1 && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends --quiet \
        build-essential curl default-jre procps python wget \
        || exit 1 && \
    echo "packages were installed." && \
    \
    if [ "${NODE_ENV}" = "development" ]; then \
        echo "Install packages for testing..." && \
        apt-get install --yes --no-install-recommends --quiet \
            fonts-ipafont-gothic unzip || exit 1 && \
        cd /tmp/ && \
        wget --no-verbose --output-document=chromium.zip https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${TEST_CHROMIUM_REVISION}%2Fchrome-linux.zip?alt=media || exit 1 && \
        unzip -q chromium.zip || exit 1 && \
        rm chromium.zip && \
        mv chrome-linux/ /opt/chromium/ && \
        /opt/chromium/chrome --version && \
        echo "packages for testing installed."; \
    fi; \
    \
    apt-get clean

# Copy files related to openapi-generator from another container
COPY --from=build-openapi-generator /opt/openapi-generator/ /opt/openapi-generator/
COPY --from=build-openapi-generator /usr/local/bin/docker-entrypoint.sh /opt/openapi-generator/

# Install npm modules for app
COPY lerna.json package.json ./
COPY packages/client/package.json ./packages/client/
COPY packages/server/package.json ./packages/server/

RUN echo "Installing npm modules..." && \
    npm install || exit 1 && \
    npm run postinstall || exit 1 && \
    echo "npm modules installed." && \
    npm cache clean --force

# Copy files for app
COPY . /opt/app/

# Build for production env
RUN if [ "${NODE_ENV}" = "production" ]; then \
    echo "Building app...\n" && \
    npm run build || exit 1 && \
    echo "build was completed." ; \
fi

# Start app
CMD ["npm", "start"]