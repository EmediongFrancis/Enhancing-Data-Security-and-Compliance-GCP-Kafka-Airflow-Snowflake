resource "aws_macie2_account" "macie" {}

# Macie S3 bucket association
resource "aws_macie2_classification_job" "macie_classification" {
  name = "MacieClassificationJob"
  s3_job_definition {
    bucket_definitions {
      account_id = var.aws_account_id
      buckets    = [aws_s3_bucket.cloudtrail_bucket.bucket]
    }
  }
  schedule_frequency = "DAILY"
  job_type           = "ONE_TIME"
  job_scope {
    scope_term {
      tag_scope_term {
        tag_values {
          key   = "data"
          value = "sensitive"
        }
      }
    }
  }
}
