provider "aws" {
  region = "us-east-1"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "sqs" {
  source = "./modules/sqs"
}

module "lambdas" {
  source                = "./modules/lambdas"
  lambda_exec_role      = aws_iam_role.lambda_exec.arn
  api_handler_zip       = "${path.module}/../lambdas/api_handler.zip"
  validator_zip         = "${path.module}/../lambdas/validator.zip"
  order_storage_zip     = "${path.module}/../lambdas/order_storage.zip"
  fulfill_order_zip     = "${path.module}/../lambdas/fulfill_order.zip"
  step_function_arn     = module.stepfunctions.order_orchestrator_arn
  orders_table_name     = module.dynamodb.orders_table_name
  failed_orders_table   = module.dynamodb.failed_orders_table_name
  order_dlq_arn         = module.sqs.order_dlq_arn
  
}

module "stepfunctions" {
  source                     = "./modules/stepfunctions"
  validator_lambda_arn       = module.lambdas.validator_lambda_arn
  order_storage_lambda_arn   = module.lambdas.order_storage_lambda_arn
  sqs_send_message_arn       = module.sqs.order_queue_arn
}

module "api_gateway" {
  source                   = "./modules/api_gateway"
  api_handler_invoke_arn   = module.lambdas.api_handler_invoke_arn
}