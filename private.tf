resource "aws_subnet" "private" {
  count             = "${var.create_private_networks ? length(data.aws_availability_zones.available.names) : 0}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 7, count.index + 10)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags   = "${merge(map(
    "Name", "${var.name}-private-${count.index}"
  ), ${var.tags})}"
}

resource "aws_route_table" "private" {
  count  = "${var.create_private_networks ? 1 : 0}"
  vpc_id = "${aws_vpc.main.id}"

  tags   = "${merge(map(
    "Name", "${var.name}-private"
  ), ${var.tags})}"
}

resource "aws_route_table_association" "private_subnets" {
  count          = "${aws_subnet.private.count}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route" "out_trough_nat" {
  count                  = "${var.create_private_networks && var.create_nat_instance ? 1 : 0}"
  route_table_id         = "${aws_route_table.private.id}"

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}