resource "aws_efs_file_system" "efs" {
  creation_token   = var.efs_name
  
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
  
  encrypted = var.efs_encryption
  
  tags = {
    Name    = var.efs_name
    Billing = var.efs_name
  }

  lifecycle_policy {
    transition_to_ia = var.transition_to_ia_time
  }
}

resource "aws_efs_backup_policy" "bck_policy" {
  file_system_id = aws_efs_file_system.efs.id
  backup_policy {
    status = var.backup_policy_status
  }

  depends_on = [
    aws_efs_file_system.efs
  ]
}