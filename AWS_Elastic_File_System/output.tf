output "efs_name" {
  value       = aws_efs_file_system.efs.creation_token
  description = "DNS Name of the FileSystem"
}

output "efs_id" {
  value = aws_efs_file_system.efs.id
  description = "ID of Elastic File System"
}