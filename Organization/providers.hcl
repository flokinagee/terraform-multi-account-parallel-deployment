generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
region              = "ap-southeast-1"
assume_role {
    role_arn = "arn:aws:iam::123456789101:role/tf-assume-role"
    
}
}
EOF
}
