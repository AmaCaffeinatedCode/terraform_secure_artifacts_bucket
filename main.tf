resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "secure_artifacts" {
  bucket = "${var.name}-${random_id.bucket_suffix.hex}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-${random_id.bucket_suffix.hex}",
      PROJECT_URL = var.project_url
    }
  )
}
