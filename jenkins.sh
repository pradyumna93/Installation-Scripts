#!/bin/bash

sudo apt update -y

sudo apt install openjdk-11-jre -y

sudo apt update -y

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo service jenkins start

cat /var/lib/jenkins/secrets/initialAdminPassword

#sudo service jenkins status


#34.232.26.121

