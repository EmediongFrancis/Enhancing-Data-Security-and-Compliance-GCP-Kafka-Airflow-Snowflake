resource "aws_datapipeline_pipeline" "data_movement_pipeline" {
  name        = "madhatter_data_movement_pipeline"
  description = "Pipeline for moving data between S3 buckets"

}

resource "aws_iam_role" "datapipeline_role" {
  name = "datapipeline_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "datapipeline.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "datapipeline_policy" {
  role       = aws_iam_role.datapipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSDataPipelineRole"
}
