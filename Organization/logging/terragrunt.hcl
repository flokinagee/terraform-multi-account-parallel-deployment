include "tf" {
  path = find_in_parent_folders("tf.hcl")
}

include "state" {
  path = find_in_parent_folders("state.hcl")
}

include "region" {
  path = find_in_parent_folders("providers.hcl")
}
