resource "aws_codestarconnections_connection" "github" {
  name          = "github-connection"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "airflow-dags-pipeline" {
  name     = "airflow-dags-pipeline"
  role_arn = aws_iam_role.pipeline_role.arn
  tags = {
    Environment = var.env
  }

  artifact_store {
    location = aws_s3_bucket.artifacts_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      configuration = {
        BranchName               = var.repository_branch
        FullRepositoryId         = "${var.repository_owner}/${var.repository_name}"
        ConnectionArn            = aws_codestarconnections_connection.github.arn
      }

      input_artifacts = []
      
      output_artifacts = [
        "SourceArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeStarSourceConnection"
      run_order = 1
      version   = "1"
    }
  }

  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        "BucketName" = var.s3_bucket_name == "" ? aws_s3_bucket.airflow_dags[0].bucket : var.s3_bucket_name
        "Extract"    = "true"
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "S3"
      run_order        = 1
      version          = "1"
    }
  }
}
