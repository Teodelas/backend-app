#Secret S3 Bucket
resource "aws_s3_bucket" "aattack-path-secret-s3-bucket" {
  bucket        = "aattack-path-secret-s3-bucket-${var.ebillingid}"
  force_destroy = true
  tags = {
    Name        = "aattack-path-secret-s3-bucket-${var.ebillingid}"
    Description = "ebilling ${var.ebillingid} S3 Bucket used for storing a secret"
    Stack       = "${var.stack-name}"
    Scenario    = "${var.scenario-name}"
    yor_trace   = "44757937-e76a-48d3-b39f-39662ea5875c"
  }
}

resource "aws_s3_bucket_object" "aattack-path-shepards-credentials" {
  bucket = "${aws_s3_bucket.aattack-path-secret-s3-bucket.id}"
  key    = "admin-user.txt"
  source = "./admin-user.txt"
  tags = {
    Name      = "aattack-path-shepards-credentials-${var.ebillingid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_trace = "db3570a5-9814-4cbc-9405-19707c9be6e5"
  }
}

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "finance-secret-s3-bucket" {
  bucket        = "finance-secret-${var.ebillingid}"
  force_destroy = true
  tags = {
    Name        = "finance-secret-${var.ebillingid}"
    Description = "ebilling ${var.ebillingid} S3 Bucket used for storing a secret"
    Stack       = "${var.stack-name}"
    Scenario    = "${var.scenario-name}"
    yor_trace   = "193295d6-1b14-4398-a208-fd9cd51d4200"
  }
}

resource "aws_s3_bucket_ownership_controls" "finance-bucket_ownership_controls" {
  bucket = aws_s3_bucket.finance-secret-s3-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "finance-bucket_public_access_block" {
  bucket = aws_s3_bucket.finance-secret-s3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "finance-bucket_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.finance-bucket_ownership_controls,
    aws_s3_bucket_public_access_block.finance-bucket_public_access_block,
  ]

  bucket = aws_s3_bucket.finance-secret-s3-bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "s3_public_objects" {
  bucket        = "${aws_s3_bucket.finance-secret-s3-bucket.id}"
  force_destroy = true
  tags = {
    Name        = "finance-secret-s3-bucket-${var.ebillingid}-public"
    Description = "ebilling ${var.ebillingid} S3 Bucket used for storing a secret"
    Stack       = "${var.stack-name}"
    Scenario    = "${var.scenario-name}"
    yor_trace   = "2de305ea-3413-46c5-85ac-d07c80127286"
  }
  key          = "admin-user.txt"
  source       = "./admin-user.txt"
  content_type = "text/plain"
}