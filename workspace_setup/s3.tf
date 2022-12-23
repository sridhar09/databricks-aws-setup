//Create an AWS S3 bucket for DBFS workspace storage, which is commonly referred to as the root bucket.
//This provider has databricks_aws_bucket_policy with the necessary IAM policy template.
//Your AWS S3 bucket must be registered using the databricks_mws_storage_configurations resource.

resource "aws_s3_bucket" "root_storage_bucket" {
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled" - TODO: review if required
  #checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default" - not required / allowed for our tier with databricks
  #checkov:skip=CKV_AWS_19: "Ensure all data stored in the S3 bucket is securely encrypted at rest" - not required / allowed for our tier with databricks
  #checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled" - not required / single region
  #checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  bucket = "${var.prefix}-databricks-${var.workspace_name}-rootbucket"
  tags   = var.default_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "root_bucket_encryption" {
  bucket = aws_s3_bucket.root_storage_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

resource "aws_s3_bucket_versioning" "root_storage_versioning" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "root_storage_bucket" {
  bucket                  = aws_s3_bucket.root_storage_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
  depends_on              = [aws_s3_bucket.root_storage_bucket]
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "databricks_aws_bucket_policy" "this" {
  bucket = aws_s3_bucket.root_storage_bucket.bucket
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  policy = data.databricks_aws_bucket_policy.this.json
}
