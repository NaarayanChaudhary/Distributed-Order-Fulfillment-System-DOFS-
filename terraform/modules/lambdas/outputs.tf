output "api_handler_invoke_arn" {
  description = "Invoke ARN for the api_handler Lambda function"
  value       = aws_lambda_function.api_handler.invoke_arn
}