

resource "aws_kms_key" "default" {
  count                    = var.enabled ? 1 : 0
  description              = var.description
  key_usage                = var.key_usage
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  customer_master_key_spec = var.customer_master_key_spec
  policy                   = var.policy
  tags                     = var.tags
}


resource "aws_kms_alias" "default" {
  count         = var.enabled ? 1 : 0
  name          = "alias/${var.kms_alias}"
  target_key_id = element(aws_kms_key.default.*.id, count.index)
}
