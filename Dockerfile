FROM node:14.16-alpine3.13

ENV GHOST_VERSION 4.13.0
ENV GHOST_CLI_VERSION 1.17.3
ENV GHOST_DIR /opt/ghost
ENV NODE_ENV production

RUN npm install -g "ghost-cli@${GHOST_CLI_VERSION}" && \
    npm cache clean --force

RUN mkdir -p ${GHOST_DIR} && chown -Rf node:node ${GHOST_DIR}

USER node

RUN ghost install -d ${GHOST_DIR} --no-prompt --db=sqlite3 --no-stack ${GHOST_VERSION} --no-setup && \
    cd ${GHOST_DIR} && \
    ghost config --ip 0.0.0.0 --port 2368 --no-prompt --url http://localhost:2368 --db=sqlite3

WORKDIR ${GHOST_DIR}

CMD ["node", "current/index.js"]

EXPOSE 2368
