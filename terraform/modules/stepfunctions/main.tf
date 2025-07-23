data "aws_iam_policy_document" "step_function_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "step_function_role" {
  name               = "step_function_role"
  assume_role_policy = data.aws_iam_policy_document.step_function_trust.json
}

resource "aws_sfn_state_machine" "order_orchestrator" {
  name     = "order_state_machine"
  role_arn = aws_iam_role.step_function_role.arn

  definition = jsonencode({
    StartAt = "ValidateOrder",
    States = {
      ValidateOrder = {
        Type     = "Task",
        Resource = var.validator_lambda_arn,
        Next     = "StoreOrder"
      },
      StoreOrder = {
        Type     = "Task",
        Resource = var.order_storage_lambda_arn,
        Next     = "PushToQueue"
      },
      PushToQueue = {
        Type     = "Task",
        Resource = var.sqs_send_message_arn,
        End      = true
      }
    }
  })
}