include "tf" {
  path = find_in_parent_folders("tf.hcl")
}

include "state" {
  path = find_in_parent_folders("state.hcl")
}

include "provider" {
  path = find_in_parent_folders("providers.hcl")
}

include "fld_dep" {
  path = find_in_parent_folders("ou_dep.hcl")
}

include "provider_acc" {
  path = find_in_parent_folders("providers_acc.hcl")
}

include "common" {
  path = find_in_parent_folders("resource_deployment.hcl")
}

inputs = {
  lvl1_role = "test-role"
  prod_automation = "123456789101"
}
