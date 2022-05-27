
{% if lambda_runtime_aws_name == "Docker" %}
  module "{{service_name}}" {
    source = "../module-lambda-service"
    ecr_repo = aws_ecr_repository.lambda_repo
    api_gateway = aws_api_gateway_rest_api.main
    image_uri = var.image_uri
    {% if environment_config.lambda_role %}
    lambda_role = "{{environment_config.lambda_role}}"
    {% else %}
    lambda_role = aws_iam_role.default_iam_for_lambda.arn
    {% endif %}

    {% if environment_config.timeout %}
    timeout = {{environment_config.timeout}}
    {% endif %}

    {% if environment_config.memory_size %}
    memory_size = {{environment_config.memory_size}}
    {% endif %}

    {% if environment_config.skip_gateway_trigger %}
    # skipping allowing lambda permissions to the API gateway
    api_gateway_trigger = false
    {% endif %}

    {% if environment_config.in_vpc %}
      vpc_subnet_ids = split(",", "{{environment_config.subnet_ids}}")
      vpc_security_groups = split(",", "{{environment_config.security_group_ids}}")
    {% endif %}
  }
{% else %}
  module "{{service_name}}" {
    source = "../module-lambda-service-dockerless"
    lambda_function_name = "{{lambda_function_name}}"
    runtime = "{{lambda_runtime_aws_name}}"
    {% if environment_config.lambda_role %}
    lambda_role = "{{environment_config.lambda_role}}"
    {% else %}
    lambda_role = aws_iam_role.default_iam_for_lambda.arn
    {% endif %}

    {% if environment_config.timeout %}
    timeout = {{environment_config.timeout}}
    {% endif %}

    {% if environment_config.memory_size %}
    memory_size = {{environment_config.memory_size}}
    {% endif %}

    {% if environment_config.in_vpc %}
      vpc_subnet_ids = split(",", "{{environment_config.subnet_ids}}")
      vpc_security_groups = split(",", "{{environment_config.security_group_ids}}")
    {% endif %}
  }
{% endif %}

{% if apigateway_enabled %}
  module "{{service_name}}_apigateway" {
    source = "../module-api-gateway"
    lambda_function_name = module.{{service_name}}.function_name
    lambda_arn = module.{{service_name}}.lambda_arn
  }

  output "{{service_name}}_invoke_url" {
    value = module.{{service_name}}_apigateway.invoke_url
  }


{% endif %}


output "{{service_name}}_function_name" {
  value = module.{{service_name}}.function_name
}

output "{{service_name}}_lambda_arn" {
  value = module.{{service_name}}.lambda_arn
}

output "{{service_name}}_lambda_invoke_arn" {
  value = module.{{service_name}}.lambda_invoke_arn
}
