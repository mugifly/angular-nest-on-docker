
FROM openapitools/openapi-generator-cli AS build-openapi-generator


FROM node:14-slim

WORKDIR /opt/app/

EXPOSE 4200

# Install apt packages
RUN echo "Installing packages..." && \
    export DEBIAN_FRONTEND="noninteractive" && \
    mkdir -p /usr/share/man/man1 && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends --quiet \
        curl procps default-jre && \
    echo "packages installed." || exit 1 && \
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
ARG NODE_ENV="production"
ENV NODE_ENV "${NODE_ENV}"
RUN if [ "${NODE_ENV}" = "production" ]; then \
    echo "Building app...\n" && \
    npm run build || exit 1; \
    echo "build was completed." ; \
fi

# Start app
CMD ["npm", "start"]