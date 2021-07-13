
module "service-{{service_name}}" {
  source = "../module-lambda-service" 
  project_name = var.project_name
  environment = var.environment
  service_name = "{{service_name}}"
  ecr_repo = aws_ecr_repository.lambda_repo
  image_uri = var.image_uri
  {% if environment_config.lambda_role %}
  lambda_role = "{{environment_config.lambda_role}}"
  {% else %}
  lambda_role = aws_iam_role.default_iam_for_lambda.arn
  {% endif %}


  {% if environment_config.in_vpc %}
    vpc_subnet_ids = split(",", "{{environment_config.subnet_ids}}")
    vpc_security_groups = split(",", "{{environment_config.security_group_ids}}")
  {% endif %}
}

output "{{service_name}}_docker_registry" {
  value = aws_ecr_repository.lambda_repo.repository_url
}

output "{{service_name}}_lb_dns" {
  value = ""
}

output "{{service_name}}_lambda_arn" {
  value = module.service-{{service_name}}.lambda_arn
}

output "{{service_name}}_lambda_invoke_arn" {
  value = module.service-{{service_name}}.lambda_invoke_arn
}
