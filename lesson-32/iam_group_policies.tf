
locals {
  group_pilicy_map_setproduct = [
    for group in var.iam_group_map :
    setproduct([group.group_name], group.group_policies)
  ]

  group_policy_map_setproduct_pairs = [
    for group in var.iam_group_map : [
      for pair in setproduct([group.group_name], group.group_policies) : {
        group_name   = pair[0]
        group_policy = pair[1]
      }
    ]
  ]

  group_policy_map_setproduct_pairs_flatten = flatten(local.group_policy_map_setproduct_pairs)

  group_policy_map_setproduct_pairs_flatten_with_key = {
    for item in local.group_policy_map_setproduct_pairs_flatten :
    "${item.group_name}__${item.group_policy}" => item
  }

  group_map_converted = {
    for item in flatten([
      for group in var.iam_group_map : [
        for pair in setproduct([group.group_name], group.group_policies) : {
          group_name   = pair[0]
          group_policy = pair[1]
        }
      ]
    ]) :
    "${item.group_name}__${item.group_policy}" => item
  }



}

resource "aws_iam_group_policy_attachment" "this" {
  for_each   = local.group_map_converted
  group      = each.value.group_name
  policy_arn = each.value.group_policy
  depends_on = [ aws_iam_group.this ]
}


output "group_pilicy_map_setproduct" {
  value = local.group_pilicy_map_setproduct
}

output "group_pilicy_map_setproduct_pairs" {
  value = local.group_policy_map_setproduct_pairs
}

output "group_policy_map_setproduct_pairs_flatten" {
  value = local.group_policy_map_setproduct_pairs_flatten
}

output "group_policy_map_setproduct_pairs_flatten_with_key" {
  value = local.group_policy_map_setproduct_pairs_flatten_with_key
}
