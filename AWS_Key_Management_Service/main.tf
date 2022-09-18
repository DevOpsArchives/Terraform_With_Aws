resource "aws_kms_key" "key" {
  description              = var.key_desc
  key_usage                = var.key_usage
  customer_master_key_spec = var.master_key_spec
  deletion_window_in_days  = var.deletion_window
  is_enabled               = var.key_enabled
  enable_key_rotation      = var.key_rotation
  multi_region             = var.multi_region

  tags = {
    Name    = var.key_tag
    Billing = var.key_tag
  }

}

resource "aws_kms_alias" "key_alias" {
  target_key_id = aws_kms_key.key.key_id
  name          = "alias/${var.key_tag}"
}