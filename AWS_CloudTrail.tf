resource "aws_cloudtrail" "cloudtrail" {
  name                          = "MadHatterCorpCloudTrail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}

# S3 bucket for CloudTrail logs
resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "madhattercorp-cloudtrail-logs"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.data_encryption_key.id
      }
    }
  }
}


resource "aws_s3_bucket_versioning" "cloudtrail_bucket" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
