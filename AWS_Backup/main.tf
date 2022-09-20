# TODO
# Vault Notifications - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault_notifications
# Backup Selection    - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection
# Lock                - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault_lock_configuration

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

resource "aws_backup_vault_policy" "vault_policy" {
  backup_vault_name = aws_backup_vault.backup_vault.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "default",
    "Statement" : [
      {
        "Sid" : "DenyActions",
        "Effect" : "Deny",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "backup:DeleteBackupVault",
          "backup:DeleteBackupVaultAccessPolicy",
          "backup:DeleteRecoveryPoint",
          "backup:StartCopyJob",
          "backup:StartRestoreJob",
          "backup:UpdateRecoveryPointLifecycle"
        ],
        "Resource" : "${aws_backup_vault.backup_vault.arn}"
      },
      {
        "Sid" : "AllowActions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "backup:DescribeBackupVault",
          "backup:PutBackupVaultAccessPolicy",
          "backup:GetBackupVaultAccessPolicy",
          "backup:StartBackupJob",
          "backup:GetBackupVaultNotifications",
          "backup:PutBackupVaultNotifications"
        ],
        "Resource" : "${aws_backup_vault.backup_vault.arn}"
      }
    ]
  })

  depends_on = [
    aws_backup_vault.backup_vault
  ]

}

resource "aws_backup_plan" "backup_name" {
  name = var.backup_plan_name

  rule {
    rule_name                = var.rule_name
    target_vault_name        = aws_backup_vault.backup_vault.name
    schedule                 = var.schedule_exp
    enable_continuous_backup = var.continuous_backup
    start_window             = var.start_window
    completion_window        = var.completion_window

    lifecycle {
      delete_after = var.retention_period
    }
  }

  tags = {
    Name    = var.backup_plan_name
    Billing = var.backup_plan_name
  }
}

resource "aws_backup_report_plan" "report_plan" {
  name        = var.backup_report_name
  description = "Report resource configuration for AWS Backup"

  report_delivery_channel {
    formats = [
      "CSV",
      "JSON"
    ]
    s3_bucket_name = var.report_bucket_name
  }

  report_setting {
    report_template = "RESTORE_JOB_REPORT"
  }

  tags = {
    Name    = var.backup_report_name
    Billing = var.backup_report_name
  }
}