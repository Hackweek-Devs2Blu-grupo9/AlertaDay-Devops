# AlertaDay Terraform Infrastructure

This Terraform configuration deploys an EC2 instance that automatically sets up and runs the AlertaDay Java application in a Docker container.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version 1.0+)
- Access to the following AWS resources:
  - VPC: `vpc-modulo9`
  - Subnet: `sn-rafael`
  - Security Group: `secgroup-AlertaDay` (must allow inbound traffic on port 8080 and SSH on port 22)
  - Key Pair: `rafael-pair`

## What This Deploys

- **EC2 Instance**: t3.small instance running Amazon Linux 2023
- **Automatic Setup**: The instance will automatically:
  - Install Docker
  - Install Git and Java 17
  - Clone the AlertaDay-Java repository
  - Build the Docker image
  - Run the application container on port 8080
  - Set up auto-restart on reboot

## Usage

1. Navigate to the terraform directory:
   ```bash
   cd infra/terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

5. After successful deployment, Terraform will output:
   - Instance ID
   - Public IP address
   - Public DNS name
   - Application URL (http://PUBLIC_IP:8080)
   - SSH connection command

## Variables

You can customize the deployment by modifying `variables.tf` or by passing variables:

```bash
terraform apply -var="aws_region=us-west-2" -var="instance_type=t3.medium"
```

Available variables:
- `aws_region`: AWS region (default: us-east-1)
- `vpc_name`: VPC name tag (default: vpc-modulo9)
- `subnet_name`: Subnet name tag (default: sn-rafael)
- `security_group_name`: Security group name tag (default: secgroup-AlertaDay)
- `key_pair_name`: SSH key pair name (default: rafael-pair)
- `instance_type`: EC2 instance type (default: t3.small)
- `instance_name`: Instance name tag (default: alertaDay-ec2)

## Accessing the Application

After deployment (allow 3-5 minutes for setup to complete):

1. Access the application via web browser:
   ```
   http://<PUBLIC_IP>:8080
   ```

2. SSH into the instance:
   ```bash
   ssh -i rafael-pair.pem ec2-user@<PUBLIC_IP>
   ```

3. Check deployment logs:
   ```bash
   cat /home/ec2-user/deployment.log
   ```

4. Check Docker container status:
   ```bash
   docker ps
   docker logs alertaday-container
   ```

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

## Security Considerations

Ensure your security group (`secgroup-AlertaDay`) has the following rules:
- Inbound: Port 22 (SSH) from your IP
- Inbound: Port 8080 (HTTP) from allowed sources
- Outbound: Allow all (for downloading packages and Docker images)

## Troubleshooting

If the application is not accessible:

1. Check if the instance is running:
   ```bash
   terraform show | grep instance_state
   ```

2. SSH into the instance and check:
   ```bash
   # Check Docker status
   sudo systemctl status docker
   
   # Check container status
   docker ps -a
   
   # View container logs
   docker logs alertaday-container
   
   # Check user data execution
   cat /var/log/cloud-init-output.log
   ```
