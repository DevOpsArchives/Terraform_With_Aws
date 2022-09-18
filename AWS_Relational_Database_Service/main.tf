resource "aws_db_instance" "rds" {
  identifier = var.db_identifier_name

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  username = var.username
  password = var.password

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  parameter_group_name        = var.param_grp_name
  skip_final_snapshot         = var.skip_final_snapshot
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately

  backup_retention_period  = var.backup_retention_period
  backup_window            = var.backup_window
  delete_automated_backups = var.delete_automated_backups
  maintenance_window       = var.maintenance_window

  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports_list
  kms_key_id                      = var.kms_arn
  monitoring_interval             = var.monitoring_interval
  deletion_protection             = var.deletion_protection
  network_type                    = var.network_type
  port                            = var.port
  publicly_accessible             = var.publicly_accessible
  storage_encrypted               = var.is_storage_encrypted
  storage_type                    = var.storage_type

  tags = {
    Name    = var.db_identifier_name
    Billing = var.db_identifier_name
  }
}