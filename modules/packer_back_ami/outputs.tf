output "ami_id" {
  value = jsondecode(aws_lambda_invocation.example.result)["ami_id"]
}

output "status" {
  value = jsondecode(aws_lambda_invocation.example.result)["status"]
}