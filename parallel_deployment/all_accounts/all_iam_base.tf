### Pipeline Level one role gets created in all accounts ###
#### DO NOT MODIFY IT ############

data "aws_caller_identity" "assume" {
  provider = aws.acc
}

resource "aws_iam_role" "role" {
  provider = aws.acc
  name                = var.lvl1_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = { 
          AWS = "${var.prod_automation}"
        }
      },
    ]
  })
  managed_policy_arns = [ "arn:aws:iam::aws:policy/AdministratorAccess"]
  tags = local.tags

}