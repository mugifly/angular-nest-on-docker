# angular-nest-on-docker

## Key Elements

- Angular v11 -- for Frontend app.
- NestJS v7 -- for Backend app.
- OpenAPI Generator CLI -- for to generate an API Client (between Angular and NestJS).
- Docker -- for Development & Production environment.
- Docker Compose -- for Development environment.
- Lerna -- for make a Monorepo structure that to have Frontend and Backend in a single repository.

## Quick Start

### Deploy on Heroku using Docker

This app supports deploying as production environment to Heroku or other Docker based server.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mugifly/angular-nest-on-docker)

### Develop on your local

Before you start, you should install the following software:

- Node.js

- Visual Studio Code

- Docker

- Docker Compose

Then execute as the following in your terminal:

```
$ git clone git@github.com:mugifly/angular-nest-on-docker.git
$ cd angular-nest-on-docker/

$ npm install

$ sudo docker-compose up -d
$ sudo docker-compose up --build app
```

After that, open the web browser and navigate to `http://localhost:4200/`.

Also, when you edit the frontend source-code, HMR applies it to your browser immediately.
