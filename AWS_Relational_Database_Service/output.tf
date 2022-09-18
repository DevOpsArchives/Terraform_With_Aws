output "rds_address" {
  value       = aws_db_instance.rds.address
  description = "The hostname of the RDS Instnace"
}

output "rds_arn" {
  value       = aws_db_instance.rds.arn
  description = "The ARN of the RDS Instnace"
}

output "rds_db_name" {
  value       = aws_db_instance.rds.db_name
  description = "The Database Name of the RDS Instnace"
}

output "rds_endpoint" {
  value       = aws_db_instance.rds.endpoint
  description = "Endpoint for RDS Instance"
}

output "rds_port" {
  value       = aws_db_instance.rds.port
  description = "Port for the RDS Instance"
}

output "rds_username" {
  value       = aws_db_instance.rds.username
  description = "Username for the RDS Instance"
}