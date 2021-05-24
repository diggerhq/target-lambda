
output "{{service_name}}_docker_registry" {
  value = aws_ecr_repository.default_repo.repository_url
}

output "{{service_name}}_lb_dns" {
  value = ""
}
