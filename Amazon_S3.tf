resource "aws_s3_bucket" "raw_data_bucket" {
  bucket = "madhatter-raw-data-bucket"
}

resource "aws_s3_bucket_acl" "madhatter_raw_bucket_acl" {
  bucket = aws_s3_bucket.raw_data_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_acl" "madhatter_processed_bucket_acl" {
  bucket = aws_s3_bucket.processed_data_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "processed_data_bucket" {
  bucket = "madhatter-processed-data-bucket"
}

resource "aws_s3_bucket_versioning" "raw_data_bucket_versioning" {
  bucket = aws_s3_bucket.raw_data_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "processed_data_bucket_versioning" {
  bucket = aws_s3_bucket.processed_data_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "raw_data_bucket_lifecycle" {
  bucket = aws_s3_bucket.raw_data_bucket.id

  rule {
    id     = "raw-data-expiration-rule"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "processed_data_bucket_lifecycle" {
  bucket = aws_s3_bucket.processed_data_bucket.id

  rule {
    id     = "processed-data-expiration-rule"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
