dependency "ou" {
  config_path = "../"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    ou_self_link = "root/o-123456/ou-vbm3-123456"
  }
}

inputs = {
  org_link = trimprefix(dependency.ou.outputs.ou_self_link, "root/o-123456/")
}
