output "automation_assume_role" {
  description = "automation assume role arn"
  value       = aws_iam_role.role.arn
}