resource "aws_cloudwatch_log_group" "main" {
  name = var.cw_name
  tags = var.tags
  retention_in_days = var.retention_in_days
  kms_key_id = var.kms_key_id
}
