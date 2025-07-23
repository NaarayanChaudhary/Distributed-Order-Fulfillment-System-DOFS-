provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "api_handler" {
  function_name = "api_handler"
  role          = var.lambda_exec_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  filename      = var.api_handler_zip
  source_code_hash = filebase64sha256(var.api_handler_zip)
  environment {
    variables = {
      STEP_FUNCTION_ARN = var.step_function_arn
    }
  }
}

resource "aws_lambda_function" "validator" {
  function_name = "validator"
  role          = var.lambda_exec_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  filename      = var.validator_zip
  source_code_hash = filebase64sha256(var.validator_zip)
}

resource "aws_lambda_function" "order_storage" {
  function_name = "order_storage"
  role          = var.lambda_exec_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  filename      = var.order_storage_zip
  source_code_hash = filebase64sha256(var.order_storage_zip)
  environment {
    variables = {
      ORDERS_TABLE = var.orders_table_name
    }
  }
}

resource "aws_lambda_function" "fulfill_order" {
  function_name = "fulfill_order"
  role          = var.lambda_exec_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  filename      = var.fulfill_order_zip
  source_code_hash = filebase64sha256(var.fulfill_order_zip)
  environment {
    variables = {
      ORDERS_TABLE = var.orders_table_name
      FAILED_TABLE = var.failed_orders_table
    }
  }
  dead_letter_config {
    target_arn = aws_sqs_queue.order_dlq.arn
  }
}