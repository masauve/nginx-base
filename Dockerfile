FROM nginx:mainline
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
ENV PORT 8080