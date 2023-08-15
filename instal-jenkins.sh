#!/bin/bash

# Update the system packages
sudo yum update -y
sleep 3

# Install required command
sudo yum install rpm -y
sudo yum install wget -y
sleep 3

# Install Java Development Kit (JDK)
sudo yum install java-11-openjdk-devel -y
sleep 3

# Add the Jenkins repository key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sleep 3

# Add the Jenkins repository to yum
sudo sh -c 'echo -e "[jenkins]\nname=Jenkins\nbaseurl=https://pkg.jenkins.io/redhat-stable\ngpgcheck=1" > /etc/yum.repos.d/jenkins.repo'
sleep 3

# Install Jenkins
sudo yum install jenkins -y
sleep 3

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins
sleep 3

#Firewall set up
echo "=====> [6]: Ajust Firewall ...."
sudo systemctl status firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

# Display initial Jenkins admin password
echo "Wait a moment for Jenkins to initialize..."
sleep 30 # Wait for Jenkins to initialize (adjust as needed)
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
