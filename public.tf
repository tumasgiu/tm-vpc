resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags   = "${merge(map(
    "Name", "${var.name}"
  ), ${var.tags})}"
}

resource "aws_subnet" "public" {
  count             = "${length(data.aws_availability_zones.available.names)}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 7, count.index)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags   = "${merge(map(
    "Name", "${var.name}-public-${count.index}"
  ), ${var.tags})}"
}

// Associate internet gateway with default vpc route table
resource "aws_route" "allow_all_in_out" {
  route_table_id         = "${aws_vpc.main.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

// Associate subnets with vpc route table
resource "aws_route_table_association" "public_subnets" {
  count          = "${aws_subnet.public.count}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_vpc.main.default_route_table_id}"
}