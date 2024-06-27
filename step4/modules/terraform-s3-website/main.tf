# terraform101 workshop
# Copyright (C) 2020 Nigel Gibbs
#
# This file is part of terraform101 workshop.
#
# terraform101 workshop is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# terraform101 workshop is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with terraform101 workshop.  If not, see <https://www.gnu.org/licenses/>.

resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket" "static_site" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = ["s3:GetObject"]
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
        Principal = "*"
      },
    ]
  })

  depends_on = [
    aws_s3_bucket.static_site,
    aws_s3_bucket_public_access_block.static_site
  ]
}

resource "aws_s3_bucket_website_configuration" "static_site_config" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index" {
  bucket         = aws_s3_bucket.static_site.bucket
  key            = "index.html"
  content_base64 = var.index_file_contents_b64
  content_type   = "text/html"
  etag           = md5(var.index_file_contents_b64)
}

resource "aws_s3_object" "error" {
  bucket         = aws_s3_bucket.static_site.bucket
  key            = "error.html"
  content_base64 = var.error_file_contents_b64
  content_type   = "text/html"
  etag           = md5(var.error_file_contents_b64)
}
