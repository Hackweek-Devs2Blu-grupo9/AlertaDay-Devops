#!/bin/bash
set -e

# Update system
yum update -y

# Install Docker
yum install -y docker

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group
usermod -a -G docker ec2-user

# Install Git
yum install -y git

# Install Java 17 (required for Maven projects)
yum install -y java-17-amazon-corretto-devel

# Wait for Docker to be fully ready
sleep 5

# Clone the repository
cd /home/ec2-user
git clone https://github.com/Hackweek-Devs2Blu-grupo9/AlertaDay-Java.git
cd AlertaDay-Java

# Build the Docker image
docker build -t alertaday-app ./alertaday-api

# Run the Docker container
docker run -d \
  --name alertaday-container \
  --restart unless-stopped \
  -p 8080:8080 \
  alertaday-app

# Create a systemd service to ensure the container starts on reboot
cat > /etc/systemd/system/alertaday.service <<EOF
[Unit]
Description=AlertaDay Docker Container
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a alertaday-container
ExecStop=/usr/bin/docker stop -t 2 alertaday-container

[Install]
WantedBy=multi-user.target
EOF

# Enable the service
systemctl enable alertaday.service

# Log completion
echo "AlertaDay deployment completed successfully" > /home/ec2-user/deployment.log
date >> /home/ec2-user/deployment.log
