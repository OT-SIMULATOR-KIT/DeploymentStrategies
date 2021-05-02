FROM ubuntu:16.04

RUN apt-get -y update && apt-get -y install software-properties-common
RUN apt-get -y update && apt-get -y install openssh-server iputils-ping
RUN apt-add-repository -y ppa:ansible/ansible && apt-get -y update && apt-get -y install ansible

COPY id_rsa.pub /root/.ssh/
COPY id_rsa /root/.ssh/

COPY id_rsa.pub /root/.ssh/authorized_keys
