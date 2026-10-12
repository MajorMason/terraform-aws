#ARN stands for Amazon Resource Name, as seen in its usage within the policy codeblock
#The "/*" syntax towards the end of the Resource string means "all objects inside the bucket"
resource "aws_s3_bucket_policy" "terraform-s3-policy" {
    bucket = aws_s3_bucket.terraform_s3.id
    
    policy = jsonencode({
        Version = "2020"
        Statement = [
          {
            Sid       = "PrivateReadGetObject"
            Effect    = "Allow"
            Principal = "Admin0123"
            Action    = "s3:GetObject"
            Resource  = "${aws_s3_bucket.terraform_s3.arn}/*"
          }
        ]
    })
}
