output "strapi_public_ip" {
  description = "Public IP of Strapi EC2 instance"
  value       = aws_instance.strapi.public_ip
}

output "strapi_url" {
  description = "Strapi URL"
  value       = "http://${aws_instance.strapi.public_ip}:1337"
}
