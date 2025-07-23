output "order_orchestrator_arn" {
  description = "ARN of the Step Functions state machine"
  value       = aws_sfn_state_machine.order_orchestrator.arn
}