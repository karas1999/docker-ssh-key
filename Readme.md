#docker-ssh-key

An SSH image which only allows key login. 

The use can only login with it's ssh key file. The password login is disabled by default.

## How to build image

1.You need to install docker first. If you don't know how to do this, refer to : [docker.com](https://www.docker.com)

2.Clone this repo:

```shell
git clone https://github.com/karas1999/docker-ssh-key.git path_to_docker-ssh
```

3.Build the image:

```
docker build -t myssh path_to_docker-ssh
```

## How to run container

1.You need to generate you own ssh key pairs. If you don't know what they are and what to do, refer to : [SSH Keys](https://wiki.archlinux.org/index.php/SSH_keys)

2.When you got your own "id_rsa.pub" file, copy that file to a folder which will be passed to the container as a volume. It must be in a folder called "sshkey" and must be named "authorized_keys". For example:

```
cp ~/.ssh/id_rsa.pub ~/shared/sshkey/authorized_keys
```

3.Run the container with commands below:

```
docker run -d -P --name testssh -v ~/shared:/vol myssh
```

4.Find the port:

```
docker port testssh 22
> 0.0.0.0:32779
```

## How to login

1.Find you docker host's IP, for example: 192.168.1.100

2.Login to the container:

```
ssh admin@192.168.1.100 -p 32779
```

NOTE1: You can only use the username "admin".

NOTE2: You can not use the password to login, you can only use the machine which contains you own private key in ~/.ssh