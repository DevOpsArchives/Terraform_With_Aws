module "kms" {
  source = "../AWS_Key_Management_Service"
}

resource "aws_backup_region_settings" "settings" {
  resource_type_opt_in_preference = {
    "Aurora"          = var.is_resource_enabled
    "DocumentDB"      = var.is_resource_enabled
    "DynamoDB"        = var.is_resource_enabled
    "EBS"             = var.is_resource_enabled
    "EC2"             = var.is_resource_enabled
    "EFS"             = var.is_resource_enabled
    "FSx"             = var.is_resource_enabled
    "S3"              = var.is_resource_enabled
    "Neptune"         = var.is_resource_enabled
    "RDS"             = var.is_resource_enabled
    "Storage Gateway" = var.is_resource_enabled
    "VirtualMachine"  = var.is_resource_enabled
  }

  resource_type_management_preference = {
    "DynamoDB" = var.is_resource_enabled
    "EFS"      = var.is_resource_enabled
  }
}

resource "aws_backup_vault" "backup_vault" {
  name        = var.vault_name
  kms_key_arn = module.kms.kms_arn

  tags = {
    Name   = var.vault_name
    Billig = var.vault_name
  }
}

resource "aws_backup_plan" "backup_name" {
  name = var.backup_plan_name

  rule {
    rule_name                = var.rule_name
    target_vault_name        = aws_backup_vault.backup_vault.name
    schedule                 = var.schedule_exp
    enable_continuous_backup = true
    start_window             = 480
    completion_window        = 2880

    lifecycle {
      delete_after = 14
    }
  }

  tags = {
    Name    = var.backup_plan_name
    Billing = var.backup_plan_name
  }
}