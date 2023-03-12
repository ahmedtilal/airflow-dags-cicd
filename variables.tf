variable "env" {
  description = "Depolyment environment"
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  default     = "eu-west-2"
}

variable "repository_branch" {
  description = "Repository branch to connect to"
  default     = "main"
}

variable "repository_owner" {
  description = "GitHub repository owner"
}

variable "repository_name" {
  description = "GitHub repository name"
}

variable "s3_bucket_name" {
  description = "S3 Bucket to deploy to"
  default     = "blue-airflow"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "dags-artifacts"
}

variable "github_token" {
  description = "Github Token"
}
