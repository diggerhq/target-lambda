
{% if environment_config.needs_aurora %}
  resource "random_password" "db_master_pass" {
    length            = 40
    special           = true
    min_special       = 5
    override_special  = "!#$%^&*()-_=+[]{}<>:?"
    keepers           = {
      pass_version  = 1
    }
  }

  resource "aws_rds_cluster_instance" "cluster_instances" {
    count              = 2
    identifier_prefix  = "${var.project_name}-${var.environment}-${count.index}"
    cluster_identifier = aws_rds_cluster.default.id
    instance_class     = "db.r4.large"
    engine             = aws_rds_cluster.default.engine
    engine_version     = aws_rds_cluster.default.engine_version
  }

  resource "aws_rds_cluster" "default" {
    cluster_identifier_prefix = "${var.project_name}-${var.environment}"
    availability_zones        = ["${var.region}a", "${var.region}b", "${var.region}c"]
    database_name             = local.database_name
    master_username           = local.database_username
    master_password           = random_password.db_master_pass
  }

  locals {
    database_address = aws_rds_cluster.default.endpoint
    database_name = "digger"
    database_username = "digger"
    database_password = random_password.db_master_pass
    database_port = aws_rds_cluster.default.port
    # database_url = "postgres://${local.database_username}:${local.database_password}@${local.database_address}:${local.database_port}/${local.database_name}"
  }

  resource "aws_ssm_parameter" "database_password" {
    name = "${var.project_name}.${var.environment}.database_password"
    value = local.database_password
    type = "SecureString"
  }

  output "DGVAR_AURORA_HOSTNAME" {
    value = local.database_address
  }

  output "DGVAR_AURORA_DBNAME" {
    value = local.database_name
  }

  output "DGVAR_AURORA_USERNAME" {
    value = local.database_username
  }

  output "DGVAR_AURORA_PASSWORD" {
    value = local.database_password
  }

  output "DGVAR_AURORA_PORT" {
    value = local.database_port
  }
{% endif %}
