resource "aws_subnet" "privateA" {
  vpc_id            = "${aws_vpc.webapp_vpc.id}"
  cidr_block        = "10.255.100.0/24"
  availability_zone = "${var.region}a"

  tags {
    Name = "PrivateA"
  }
}

resource "aws_subnet" "privateB" {
  vpc_id            = "${aws_vpc.webapp_vpc.id}"
  cidr_block        = "10.255.101.0/24"
  availability_zone = "${var.region}b"

  tags {
    Name = "PrivateB"
  }
}

resource "aws_subnet" "privateC" {
  vpc_id            = "${aws_vpc.webapp_vpc.id}"
  cidr_block        = "10.255.102.0/24"
  availability_zone = "${var.region}c"

  tags {
    Name = "PrivateC"
  }
}

resource "aws_route_table_association" "privateA" {
  subnet_id      = "${aws_subnet.privateA.id}"
  route_table_id = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "privateB" {
  subnet_id      = "${aws_subnet.privateB.id}"
  route_table_id = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "privateC" {
  subnet_id      = "${aws_subnet.privateC.id}"
  route_table_id = "${aws_route_table.private_route.id}"
}
