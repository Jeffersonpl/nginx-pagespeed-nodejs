FROM ubuntu

MAINTAINER Jefferson Pereira Leite <jefferson@jeffersonpl.com.br>

RUN apt-get update

RUN apt-get install -y curl build-essential zlib1g-dev libpcre3-dev unzip uuid-dev wget sudo libssl-dev openssl

ADD ./docker/install/pagespeed /pagespeed

RUN  bash pagespeed \ --nginx-version latest

RUN apt-get install -y nodejs 

RUN apt-get install -y npm && apt-get clean

ADD ./docker/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf

ADD ./docker/nginx/default.txt /etc/nginx/sites-enabled/default

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT ["/usr/local/nginx/sbin/nginx"] 

CMD ["start", "-g"]


