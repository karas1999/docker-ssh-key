############################################################
# Dockerfile to build gollum-cms container images
# Based on ruby
############################################################

FROM ubuntu:14.04
MAINTAINER Karas Shi <karasshi@gmail.com>

RUN apt-get -y update && apt-get -y install \
  ssh \ 
  openssh-server 

# Add user "admin" with password "admin"
RUN useradd -m -g sudo -p 'admin' admin
RUN echo 'admin:admin' | chpasswd

# Disable root login &
# Disable password login, only allow public key. 
ADD ./sshd_config /etc/ssh/sshd_config

RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

RUN mkdir /home/admin/.ssh

EXPOSE 22

CMD /bin/cp /vol/sshkey/authorized_keys /home/admin/.ssh/authorized_keys; /usr/sbin/sshd -D