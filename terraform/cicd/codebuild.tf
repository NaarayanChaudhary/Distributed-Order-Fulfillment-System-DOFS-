resource "aws_codebuild_project" "dofs_project" {
  name          = "dofs-codebuild-project"
  description   = "CodeBuild project for DOFS Terraform deployment"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    environment_variables = [
      {
        name  = "TF_VAR_region"
        value = "us-east-1"
      }
    ]
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "${path.module}/buildspec.yml"
  }
}