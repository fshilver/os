#!/bin/bash

#########################################
# install docker & docker-compose

sudo yum remove -y docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-selinux \
	docker-engine-selinux \
	docker-engine

sudo yum install -y yum-utils \
	device-mapper-persistent-data \
	lvm2

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo


sudo yum install -y docker-ce-17.12.1.ce-1.el7.centos

sudo systemctl start docker
sudo systemctl enable docker


# docker-compose 설치
sudo curl -L "https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
docker-compose --version




#########################################
# install nvidia driver & nvidia-docker

sudo yum install -y epel-release
sudo yum install -y dkms


curl -O http://us.download.nvidia.com/XFree86/Linux-x86_64/410.78/NVIDIA-Linux-x86_64-410.78.run
chmod +x NVIDIA-Linux-x86_64-410.78.run
sudo rmmod nouveau

sudo ./NVIDIA-Linux-x86_64-410.78.run --ui=none -q --dkms -Z

# nvidia docker
sudo docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo yum remove -y nvidia-docker

# Add nvidia repository
sudo curl -s -L https://nvidia.github.io/nvidia-docker/centos7/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo

sudo yum install -y nvidia-docker2-2.0.3-1.docker17.12.1.ce.noarch \
                    nvidia-container-runtime-2.0.0-1.docker17.12.1.x86_64

sudo pkill -SIGHUP dockerd

rm -f NVIDIA-Linux-x86_64-410.78.run
