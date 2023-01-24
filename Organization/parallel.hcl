generate "iam_all" {
  path      = "iam_all.tf"
  if_exists = "overwrite"
  #contents = "${get_parent_terragrunt_dir()}/custom_resources/iam_role.tf"
  contents = run_cmd("--terragrunt-quiet", "cat", "${path_relative_from_include()}/../parallel_deployment/iam_all.tf")
}