
variable "lambda_exec_role" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "api_handler_zip" {
  description = "Path to zipped source code for api_handler lambda"
  type        = string
}

variable "validator_zip" {
  description = "Path to zipped source code for validator lambda"
  type        = string
}

variable "order_storage_zip" {
  description = "Path to zipped source code for order_storage lambda"
  type        = string
}

variable "fulfill_order_zip" {
  description = "Path to zipped source code for fulfill_order lambda"
  type        = string
}

variable "step_function_arn" {
  description = "ARN of the Step Function to invoke from api_handler"
  type        = string
}

variable "orders_table_name" {
  description = "Name of the DynamoDB orders table"
  type        = string
}

variable "failed_orders_table" {
  description = "Name of the DynamoDB failed orders table"
  type        = string
}

variable "order_dlq_arn" {
  description = "ARN of the Dead Letter Queue for fulfill_order Lambda"
  type        = string
}
