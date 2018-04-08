resource "aws_route_table" "private_route" {
  vpc_id = "${aws_vpc.webapp_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw.id}"
  }

  tags {
    Name = "Private Route Table"
  }
}
