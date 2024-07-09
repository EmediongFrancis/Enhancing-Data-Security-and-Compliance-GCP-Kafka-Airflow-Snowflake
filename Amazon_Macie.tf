resource "aws_macie2_account" "macie" {}

# Macie S3 bucket association
resource "aws_macie2_classification_job" "macie_classification" {
  name = "MacieClassificationJob"
  s3_job_definition {
    bucket_definitions {
      account_id = 123456789
      buckets    = [aws_s3_bucket.cloudtrail_bucket.bucket]
    }
  }

  job_type = "ONE_TIME"
}
