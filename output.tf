output "vpc_id" {
	value = "${aws_vpc.main.id}"
}

output "vpc_cidr" {
	value = "${aws_vpc.main.cidr_block}"
}

output "private_subnets_ids" {
	value = "${aws_subnet.private.*.id}"
}

output "private_subnets_cidr_blocks" {
	value = "${aws_subnet.private.*.cidr_block}"
}

output "private_subnets_route_table_id" {
	// https://github.com/hashicorp/hil/issues/50
	value = "${join("", aws_route_table.private.*.id)}"
}

output "public_subnets_ids" {
	value = "${aws_subnet.public.*.id}"
}

output "public_subnets_cidr_blocks" {
	value = "${aws_subnet.public.*.cidr_block}"
}

output "public_subnets_route_table_id" {
	value = "${aws_vpc.main.default_route_table_id}"
}

output "nat_public_ip" {
	value = "${join("", aws_eip.nat.*.public_ip)}"
}

output "db_subnets_ids" {
	value = "${aws_subnet.db.*.id}"
}

output "db_subnets_cidr_blocks" {
	value = "${aws_subnet.db.*.cidr_block}"
}

output "db_subnets_route_table_id" {
	// https://github.com/hashicorp/hil/issues/50
	value = "${join("", aws_route_table.db.*.id)}"
}

output "internal_zone_id" {
	value = "${aws_route53_zone.internal.id}"
}