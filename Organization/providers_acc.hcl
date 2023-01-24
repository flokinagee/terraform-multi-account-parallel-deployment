locals {
    all_accounts = read_terragrunt_config(find_in_parent_folders("accounts.hcl"))
    account_id = lookup(local.all_accounts.inputs, basename(abspath(get_terragrunt_dir())))
}


generate "custom_provider" {
  path      = "provider_acc.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
region              = "ap-southeast-1"
alias               = "acc"
assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/OrganizationAccountAccessRole"
    
}
}
EOF
}