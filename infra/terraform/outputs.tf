output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.alertaday.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.alertaday.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.alertaday.public_dns
}

output "application_url" {
  description = "URL to access the AlertaDay application"
  value       = "http://${aws_instance.alertaday.public_ip}:8080"
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh -i ${var.key_pair_name}.pem ec2-user@${aws_instance.alertaday.public_ip}"
}
