
module {
  source = "../module-lambda-service" 
  project_name = var.project_name
  environment = var.environment
  service_name = "{{service_name}}"
  ecr_repo = aws_ecr_repository.lambda_repo
  api_gateway = aws_api_gateway_rest_api.main
}

output "{{service_name}}_docker_registry" {
  value = aws_ecr_repository.lambda_repo.repository_url
}

output "{{service_name}}_lb_dns" {
  value = ""
}
