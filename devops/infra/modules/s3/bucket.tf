# --> BUCKET USER to access the bucket and Policy (with write permissions)
resource "aws_iam_user" "bucket_user" {
  name = "hellolambda_s3bucketuser_${var.environment}"

  tags = {
    Name = "hellolambdabucket"
    Environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "policy" {
  name = "hellolambda-${var.environment}-s3-access-policy"
  description = "hellolambda ${var.environment} policy"
  policy = templatefile("s3_policy_bucket_permissions.json", {BUCKET_NAME=var.hellolambda_aws_s3_bucket})
}

resource "aws_iam_user_policy_attachment" "policy-attach" {
  user       = aws_iam_user.bucket_user.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_access_key" "user_access_key" {
  user = aws_iam_user.bucket_user.name
}


# --> BUCKET for lambda-code (private)
resource "aws_s3_bucket" "hellolambda_s3_bucket_lambda" {
  bucket = "${var.hellolambda_aws_s3_bucket}"

  tags = {
    Name = "hellolambdabucket"
    Environment = "${var.environment}"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_public_access_block" "hellolambda_s3_bucket_lambda" {
  bucket = aws_s3_bucket.hellolambda_s3_bucket_lambda.id

  block_public_acls   = true
  block_public_policy = true
}
