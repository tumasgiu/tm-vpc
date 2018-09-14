resource "aws_subnet" "db" {
  count             = "${var.create_db_networks ? length(data.aws_availability_zones.available.names) : 0}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 7, count.index + 20)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags   = "${merge(map(
    "Name", "${var.name}-db-${count.index}"
  ), ${var.tags})}"
}

resource "aws_route_table" "db" {
  count  = "${var.create_db_networks ? 1 : 0}"
  vpc_id = "${aws_vpc.main.id}"

  tags   = "${merge(map(
    "Name", "${var.name}-db"
  ), ${var.tags})}"
}

resource "aws_route_table_association" "db_subnets" {
  count          = "${aws_subnet.db.count}"
  subnet_id      = "${element(aws_subnet.db.*.id, count.index)}"
  route_table_id = "${aws_route_table.db.id}"
}

resource "aws_route" "db_out_trough_nat" {
  count                  = "${var.create_db_networks ? 1 : 0}"
  route_table_id         = "${aws_route_table.db.id}"

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

