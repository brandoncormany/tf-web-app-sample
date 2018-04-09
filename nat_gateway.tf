resource "aws_eip" "natIP" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.natIP.id}"
  subnet_id     = "${aws_subnet.publicA.id}"

  tags {
    Name = "NAT Gateway"
  }
}
