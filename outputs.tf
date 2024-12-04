output "id_instancia" {
  description = "ID of the Instância"
  value       = aws_instance.learn-terraform-aws.id
}

output "ip_publico_instancia" {
  description = "IP público da Instância"
  value       = aws_instance.learn-terraform-aws.public_ip
}

output "ip_publico_instancia_canonical" {
  description = "IP público da Instância"
  value       = aws_instance.srv_ubuntu_canonical.public_ip
}