
output "vpc_flow_log" {
  description = "VPC Flow log ARN"
  value       = aws_flow_log.main.arn
}