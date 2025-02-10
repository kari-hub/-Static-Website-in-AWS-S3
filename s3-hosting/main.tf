terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.aws_bucket_name
}

/*
resource "aws_s3_bucket_acl" "website_bucket_acl" {
  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
} */

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${var.aws_bucket_name}/*"
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "website_bucket_website_configuration" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "website_bucket_files" {
  for_each = fileset("${path.module}/website", "**/*")

  bucket = aws_s3_bucket.website_bucket.id
  key    = each.key
  source = "${path.module}/website/${each.key}"

  content_type = lookup(
    {
      "html" = "text/html"
      "css"  = "text/css"
      "js"   = "application/javascript"
      "png"  = "image/png"
      "jpg"  = "image/jpeg"
      "jpeg" = "image/jpeg"
      "svg"  = "image/svg+xml"
    },
    split(".", each.key)[length(split(".", each.key)) - 1],
    "application/octet-stream"
  )

  etag = filemd5("${path.module}/website/${each.key}")
  acl  = "public-read"
}
