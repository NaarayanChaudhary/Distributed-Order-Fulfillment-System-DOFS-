output "order_queue_arn" {
  description = "ARN of the main SQS order queue"
  value       = aws_sqs_queue.order_queue.arn
}

output "order_dlq_arn" {
  description = "ARN of the dead-letter SQS queue"
  value       = aws_sqs_queue.order_dlq.arn
}