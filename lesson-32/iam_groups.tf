locals {
  group_map_with_key = { for group in var.iam_group_map : group.group_name => group }
}

resource "aws_iam_group" "this" {
  for_each = local.group_map_with_key
  name     = each.value.group_name
}


output "group_map_with_key" {
  value = local.group_map_with_key
}
