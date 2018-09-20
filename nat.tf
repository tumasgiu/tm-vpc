resource "aws_eip" "nat" {
	count = "${var.create_private_networks || var.create_db_networks ? 1 : 0}"
	vpc   = true

	tags  = "${merge(map(
    "Name", "${var.name}-nat"
  	), var.tags)}"
}

resource "aws_nat_gateway" "nat" {
	count         = "${(var.create_private_networks || var.create_db_networks) && var.create_nat_instance ? 1 : 0}"
	allocation_id = "${aws_eip.nat.id}"
	subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

	tags          = "${merge(map(
    "Name", "${var.name}"
  	), var.tags)}"
}
