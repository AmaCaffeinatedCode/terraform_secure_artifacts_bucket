resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "secure_artifacts" {
  bucket = "${var.name}-${random_id.bucket_suffix.hex}"

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-${random_id.bucket_suffix.hex}",
      PROJECT_URL = var.project_url
    }
  )
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.secure_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
