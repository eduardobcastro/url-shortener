FROM node:latest
WORKDIR /build

COPY yarn.lock package.json ./

RUN yarn install

COPY /. ./

ARG VUE_APP_API=/graphql
RUN yarn build

FROM nginx:alpine
COPY --from=0 /build/dist/. /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf