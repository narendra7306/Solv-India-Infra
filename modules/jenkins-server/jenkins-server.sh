#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -ex

# Update package index
sudo apt-get update -y
sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install -y ca-certificates curl gnupg fontconfig openjdk-17-jre

# Set JAVA_HOME
JAVA_PATH=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
echo "JAVA_HOME=${JAVA_PATH}" | sudo tee -a /etc/environment
export JAVA_HOME="${JAVA_PATH}"

# Create Jenkins keyring directory and import GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null
sudo chmod 644 /etc/apt/keyrings/jenkins-keyring.asc

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list with new Jenkins repo
sudo apt-get update -y

# Install Jenkins
sudo apt-get install -y jenkins

# Optionally set JAVA_HOME for Jenkins explicitly
echo "JAVA_HOME=${JAVA_PATH}" | sudo tee -a /etc/default/jenkins

# Enable and start Jenkins
sudo systemctl daemon-reexec
sudo systemctl enable jenkins
sudo systemctl restart jenkins
