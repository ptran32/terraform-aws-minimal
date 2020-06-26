output "public_ip" {
  description = "List of public IP assigned to the instances"
  value = aws_instance.this.*.public_ip
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.this.*.private_ip
}
