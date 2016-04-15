#docker-ssh-key

An SSH image which only allows key login. 

## ADVANTAGES

1. The use can only login with it's ssh key file. The password login is disabled by default.

2. Use the outside VOLUME to control the image start command, don't need to rebuild the image any more.  

## (Optional) Build image from git

If you want to buid the image yourself: 

1. You need to install docker first. If you don't know how to do this, refer to : [docker.com](https://www.docker.com)

2. Clone this repo:

        git clone https://github.com/karas1999/docker-ssh-key.git path_to_docker-ssh

3. Build the image:

        docker build -t myssh path_to_docker-ssh

## Get image from docker hub (Suggested)

1. Install [Docker](https://www.docker.com).

2. Open your docker terminal

3. Pull the image from docker:

        docker pull karasshi/ssh-key

## How to run container

1. You need to generate you own ssh key pairs. If you don't know what they are and what to do, refer to : [SSH Keys](https://wiki.archlinux.org/index.php/SSH_keys)

2. When you got your own "id_rsa.pub" file, copy that file to a folder which will be passed to the container as a volume. It must be in a folder called "sshkey" and must be named "authorized_keys". For example:

        cp ~/.ssh/id_rsa.pub ~/volume/sshkey/authorized_keys

3. Make a start.sh file in "volume" folder to control the start process of the container:

    1. Make a new file called start.sh.

    2. Edit the file as follow:

            #!/bin/bash

            echo 'Begin start.sh...'

            # You can add any command you need here:

            # Copy the user-defined public keys to ssh
            /bin/cp /vol/sshkey/authorized_keys /home/admin/.ssh/authorized_keys

            # Start ssh server
            /usr/sbin/sshd -D

            echo 'start.sh ended.'

    3.  Save the file in ```~/volume/start``` folder.

4. Run the container with commands below:

        docker run -d -P --name testssh -v ~/volume:/vol karasshi/ssh-key

5. Find the port:

        docker port testssh 22
        > 0.0.0.0:32779

## How to login

1. Find you docker host's IP, for example: 192.168.1.100

2. Login to the container:

        ssh admin@192.168.1.100 -p 32779

    NOTE1: You can only use the username "admin".

    NOTE2: You can not use the password to login, you can only use the machine which contains you own private key in ~/.ssh