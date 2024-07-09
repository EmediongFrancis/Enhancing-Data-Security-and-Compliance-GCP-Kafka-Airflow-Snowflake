resource "aws_iam_policy" "access_control_policy" {
  name        = "AccessControlPolicy"
  description = "IAM policy for access control"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "access_control_role" {
  name = "AccessControlRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "access_control_policy_attachment" {
  role       = aws_iam_role.access_control_role.name
  policy_arn = aws_iam_policy.access_control_policy.arn
}

# Create a KMS key
resource "aws_kms_key" "data_encryption_key" {
  description             = "KMS key for data encryption"
  deletion_window_in_days = 10
}
