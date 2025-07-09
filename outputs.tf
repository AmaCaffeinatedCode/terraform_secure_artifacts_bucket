output "bucket_id" {
  description = "The name (ID) of the S3 bucket"
  value       = aws_s3_bucket.secure_artifacts.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.secure_artifacts.arn
}

output "bucket_name" {
  description = "The generated unique bucket name"
  value       = aws_s3_bucket.secure_artifacts.bucket
}
