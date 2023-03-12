resource "aws_s3_bucket" "airflow_dags" {
  count  = var.s3_bucket_name == "" ? 1 : 0
  bucket = "airflow-dags-${var.env}"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  count  = var.s3_bucket_name == "" ? 1 : 0
  bucket = var.s3_bucket_name == "" ? aws_s3_bucket.airflow_dags[0].id : var.s3_bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count  = var.s3_bucket_name == "" ? 1 : 0
  bucket = var.s3_bucket_name == "" ? aws_s3_bucket.airflow_dags[0].id : var.s3_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "artifacts_bucket" {
  bucket        = var.artifacts_bucket_name
  force_destroy = true
}
