
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cidr |  | string | - | yes |
| create_db_networks | Whether or not to create db subnets | string | `false` | no |
| create_nat_instance | Whether or not to create and attach a nat instance to private and db subnets | string | `true` | no |
| create_private_networks | Whether or not to create private subnets | string | `true` | no |
| name |  | string | - | yes |
| tags | Tags you want to apply to the resources that support it (eg. Environment, Project, ...) | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| db_subnets_cidr_blocks |  |
| db_subnets_ids |  |
| db_subnets_route_table_id |  |
| nat_public_ip |  |
| private_subnets_cidr_blocks |  |
| private_subnets_ids |  |
| private_subnets_route_table_id |  |
| public_subnets_cidr_blocks |  |
| public_subnets_ids |  |
| public_subnets_route_table_id |  |
| vpc_cidr |  |
| vpc_id |  |
