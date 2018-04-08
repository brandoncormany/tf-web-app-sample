resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = ""
  subnet_id = "${aws_subnet.publicA.id}"

  tags {
    Name = "NAT Gateway"
  }
}