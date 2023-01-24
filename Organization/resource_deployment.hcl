locals {
  copy_files = run_cmd("sh", "${path_relative_from_include()}/../parallel_deployment/main.sh",  "${get_terragrunt_dir()}", "${path_relative_from_include()}/../parallel_deployment")
}