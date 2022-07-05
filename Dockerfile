FROM nginx:mainline
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && sed -i.bak 's/listen\(.*\)80;/listen 8080;/' /etc/nginx/conf.d/default.conf
ENV PORT 8080