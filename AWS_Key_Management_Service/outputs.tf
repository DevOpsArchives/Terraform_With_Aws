output "key_id" {
  value       = aws_kms_key.key.id
  description = "Customer Managed Key ID"
}

output "kms_arn" {
  value       = aws_kms_key.key.arn
  description = "Customer Managed Key Arn"
}