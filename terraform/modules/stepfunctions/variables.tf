variable "validator_lambda_arn" {
  description = "ARN of the validator Lambda function"
  type        = string
}

variable "order_storage_lambda_arn" {
  description = "ARN of the order storage Lambda function"
  type        = string
}

variable "sqs_send_message_arn" {
  description = "ARN for sending messages to SQS (usually Lambda or SQS ARN)"
  type        = string
}