resource "aws_route53_zone" "internal" {
	count = "${var.internal_domain == "" ? 0 : 1}"

	vpc {
		vpc_id = "${aws_vpc.main.id}"
	}

	name  = "${var.internal_domain}"
}