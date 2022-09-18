output "key_id" {
  value       = aws_kms_key.key.id
  description = "Customer Managed Key ID"
}