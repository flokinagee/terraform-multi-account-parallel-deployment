resource "aws_flow_log" "main" {
  log_destination = module.log_group.cw_loggrop_arn
  iam_role_arn = aws_iam_role.main.arn
  vpc_id = var.vpc_id
  traffic_type = "ALL"
}

resource "aws_flow_log" "s3" {
  count = var.log_destination_s3 ? 1 : 0
  log_destination = var.vpc_flowlog_bucket_arn
  log_destination_type = "s3"
  vpc_id = var.vpc_id
  traffic_type = "ALL"
}

module "log_group"{
  source = "../log_group/"
  cw_name = "aor-cwl-cld-${var.vpc_name}"
  retention_in_days = var.logs_retention
  kms_key_id = var.cw_kms
  tags = {
    "Name" = "${var.vpc_name}-CW-LogGroup"
  }
}

data "aws_iam_policy_document" "assume_role_policy"{
statement {
  actions = ["sts:AssumeRole"]
  principals {
    type = "Service"
    identifiers = [ "vpc-flow-logs.amazonaws.com"]
  }
}
}

data "aws_iam_policy_document" "role_policy"{
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroup",
      "logs:DescribeLogStreams",
    ]
    resources = ["${module.log_group.cw_loggrop_arn}:*"]
  }
}

resource "aws_iam_role" "main" {
  name = "aor-role-cld-${var.vpc_name}-log"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  description = "Allows EC2 instances to call IM Policy for CSR"
}

resource "aws_iam_role_policy" "main" {
  name = "aor-policy-cld-${var.vpc_name}-log"
  role = aws_iam_role.main.id
  policy = data.aws_iam_policy_document.role_policy.json
}