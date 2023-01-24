terraform {
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=20m"]
  }
  extra_arguments "custom_var" {
    commands           = get_terraform_commands_that_need_vars()
    optional_var_files = ["${get_terragrunt_dir()}/variables.tfvars"]
  }
}

inputs = {
tfl_role = "test-role1"
tf_bucket = "state-bucket"
prod_automation = "013768294884"
}