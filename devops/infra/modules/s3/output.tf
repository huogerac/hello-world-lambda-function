output "access_key_id" {
  description = "The value to be stored into your app to access the new bucket"
  value = aws_iam_access_key.user_access_key.id
}

output "secret_access_key" {
  description = "The value to be stored into your app to access the new bucket"
  value = aws_iam_access_key.user_access_key.secret
  sensitive = true
}

output "s3_bucket_name" {
    description = "Bucket private for lambda code"
    value = aws_s3_bucket.hellolambda_s3_bucket_lambda.id
}
