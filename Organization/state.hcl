remote_state {
  backend = "s3"
  config = {
    bucket         = get_env("TF_VAR_tfstate_bucket", "state-bucket")
    key            = "level0/${path_relative_to_include()}/terraform.tfstate"
    region         = get_env("TF_VAR_global_location", "ap-southeast-1")
    encrypt        = true
    dynamodb_table = "terraform-state-locking"
  }
}
