terraform {
  required_providers {
      github = {
      source  = "integrations/github"
      version = ">= 5.0"
    }
    aws = {
      version = ">= 4.0"
    }
}
}

provider "aws" {
  region  = var.region
}

provider "github" {
  token   = var.github_token
  owner   = var.repository_owner
}
