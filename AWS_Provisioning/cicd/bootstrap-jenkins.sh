#!/usr/bin/env bash

exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

sudo yum install -y wget
sudo yum update
#sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
#sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y remove java-1.7.0-openjdk
sudo yum -y install java-1.8.0

sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey
sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'
sudo yum install -y atom

sudo yum -y install git
sudo yum groupinstall "Development Tools" -y
sudo yum install gtk+-devel gtk2-devel -y
sudo yum install GConf2 -y
sudo yum install Xvfb -y


#sudo service docker start
#sudo usermod -a -G docker ec2-user
#sudo pip install docker-compose
sudo pip install backports.ssl_match_hostname --upgrade

curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
sudo yum -y install nodejs
sudo yum -y install gcc-c++ make
sudo npm install -y -g xvfb-maybe

sudo yum install jenkins -y
#sudo usermod -a -G docker jenkins
#sudo usermod -a -G docker dd-agent

sudo service jenkins start

#docker run -d --name dd-agent -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /cgroup/:/host/sys/fs/cgroup:ro -e API_KEY=503a19af5fbb1affa42e535f807d6ac8 -e SD_BACKEND=docker datadog/docker-dd-agent:latest


touch ec2-init-done.markerfile
