# The base image is the latest 8.x node (LTS)
FROM node:8.15.1@sha256:abdac2bc73065470bdd8e765c12d44ae32079d6b1fb98a49b2276ee7a0d1f778

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY install/package.json /usr/src/app/package.json
RUN npm install && npm cache clean --force
COPY . /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

CMD ./nodebb start

# the default port for NodeBB is exposed outside the container
EXPOSE 4567