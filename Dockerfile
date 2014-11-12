FROM ubuntu:14.04
MAINTAINER Gabriel Melillo "gabriel@melillo.me"

RUN apt-get update && apt-get -y upgrade
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

RUN echo "Europe/Berlin" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get -y install openjdk-7-jdk wget

RUN wget -O alfresco-community-5.0.b-installer-linux-x64.bin \
	http://dl.alfresco.com/release/community/5.0.b-build-00092/alfresco-community-5.0.b-installer-linux-x64.bin
RUN chmod +x alfresco-community-5.0.b-installer-linux-x64.bin

RUN ./alfresco-community-5.0.b-installer-linux-x64.bin \
	--mode text \
	--installer-language en \
	--baseunixservice_install_as_service 1 \
	--alfresco_admin_password AlfrescoAdmin

RUN apt-get install openssh-server

RUN service alfresco start

EXPOSE 80

CMD service ssh stop && service alfresco start
