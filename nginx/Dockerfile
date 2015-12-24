FROM ubuntu:trusty

MAINTAINER Jared Hilgefort "jared.hilgefort@gmail.com"

RUN apt-get update && apt-get upgrade -y

#install nginx
RUN apt-get -y install nginx

#stop the service
RUN service nginx stop

#create new user with sudo rights to run nginx
RUN useradd --no-create-home nginx && \
mkdir /opt/nginx && \
chown nginx:nginx /opt/nginx && \
chmod 774 /opt/nginx

#Pull github project
RUN mkdir /github && \
cd /github && \
git clone https://github.com/hilgefjm/soccer-demo.git

#Add keys to server
RUN apt-get -y install openssh-server && \
  adduser --home /home/hilgefjm --shell /bin/bash --ingroup sudo --gecos "" --disabled-password hilgefjm && \
  mkdir /home/hilgefjm/.ssh && \
  mkdir /home/hilgefjm/.ssh/authorized_keys
ADD hilgefjm.pub /home/hilgefjm/.ssh/authorized_keys/hilgefjm.pub

RUN mkdir -p /startup
ADD docker-startup.sh /startup/docker-startup.sh
ADD nginx.conf /opt/nginx/nginx.conf

EXPOSE 8080 80

CMD /bin/sh /startup/docker-startup.sh
