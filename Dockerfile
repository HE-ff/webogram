FROM node:12.8.1-buster as webogram-stage
ADD . /opt/webogram
WORKDIR /opt/webogram
RUN npm install -g gulp && npm install
RUN  gulp clean
RUN gulp publish


FROM ubuntu:latest as nginx-stage
RUN apt -q update
RUN apt -qy install iptables nginx redsocks procps curl
# change to your domain dir from nginx.conf
COPY --from=webogram-stage /opt/webogram/dist/. /var/www/yourdomain.com
COPY  ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY  ./nginx/.htpasswd /etc/nginx/.htpasswd
COPY  ./nginx/certs /etc/nginx/certs
ADD /redsocks/redsocks.conf /tmp/
ADD /redsocks/redsocks /root/
RUN chmod 755 /root/redsocks
EXPOSE 80 443
CMD /root/redsocks
