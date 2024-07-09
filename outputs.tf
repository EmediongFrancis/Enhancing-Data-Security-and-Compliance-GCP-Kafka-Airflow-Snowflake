output "kms_key_arn" {
  value = aws_kms_key.data_encryption_key.arn
}

output "cloudtrail_arn" {
  value = aws_cloudtrail.cloudtrail.arn
}
