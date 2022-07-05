FROM node:14-buster AS build

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN yarn install
RUN yarn workspace app build



FROM nginx:mainline

RUN apt-get update && apt-get -y install jq && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/packages/app/dist /usr/share/nginx/html
COPY docker/default.conf.template /etc/nginx/templates/default.conf.template

COPY docker/inject-config.sh /docker-entrypoint.d/40-inject-config.sh

RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && sed -i.bak 's/listen\(.*\)80;/listen 8080;/' /etc/nginx/conf.d/default.conf


ENV PORT 8080