FROM java:openjdk-8u45-jdk

MAINTAINER Jared Hilgefort "jared.hilgefort@gmail.com"

RUN apt-get update && apt-get upgrade -y

#Pull github project
RUN mkdir /github && \
cd /github && \
git clone https://github.com/hilgefjm/sports-service-login.git

#Set JAVA_HOME & PATH environment variable
RUN sudo echo 'JAVA_HOME="/usr/lib/jvm/open-jdk"' >> /etc/environment && \
source /etc/environment

#Set java user
RUN useradd --home /opt/java java

#Add keys to server
RUN apt-get -y install openssh-server && \
  adduser --home /home/hilgefjm --shell /bin/bash --ingroup sudo --gecos "" --disabled-password hilgefjm && \
  mkdir /home/hilgefjm/.ssh && \
  mkdir /home/hilgefjm/.ssh/authorized_keys
ADD hilgefjm.pub /home/hilgefjm/.ssh/authorized_keys/hilgefjm.pub

RUN mkdir -p /startup
ADD docker-startup.sh /startup/docker-startup.sh
ADD db-env.conf /opt/java/db.conf

EXPOSE 8080

CMD /bin/sh /startup/docker-startup.sh
