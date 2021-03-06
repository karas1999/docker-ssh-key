############################################################
# An SSH image which only allows key login. 
# The use can only login with it's ssh key file. The password login is disabled by default.
# https://github.com/karas1999/docker-ssh-key.git
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

# Add sshd running directory.
RUN mkdir -m 755 /var/run/sshd

# Add ssh key directory.
RUN mkdir /home/admin/.ssh

# Copy the default start.sh file to /vol/start. 
# You can override this file by mount another folder to /vol
VOLUME /vol
ADD ./start.sh /vol/start/start.sh

EXPOSE 22

CMD bash -C /vol/start/start.sh