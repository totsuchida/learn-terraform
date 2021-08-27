resource "aws_s3_bucket" "alb-log-bucket" {
  bucket = "${var.PROJECT}-alb-log"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "alb-log-bucket-policy" {
  bucket = aws_s3_bucket.alb-log-bucket.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::<account-id>:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.alb-log-bucket.arn}/*"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.alb-log-bucket.arn}/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        "Action" : "s3:GetBucketAcl",
        "Resource" : aws_s3_bucket.alb-log-bucket.arn
      }
    ]
  })
}