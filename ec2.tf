data "template_file" "userdata" {
  template = "${file("userdata.tpl")}"

  vars {
    region = "${var.region}"
  }
}

resource "aws_launch_configuration" "webappLC" {
  name_prefix          = "tf-jenkins-lc"
  image_id             = "${lookup(var.ecs_ami, var.region)}"
  instance_type        = "t2.large"
  iam_instance_profile = "Ec2Role"                                    //Needs to be preconfigured based on role created in IAM
  security_groups      = ["${aws_default_security_group.default.id}"]
  user_data            = "${data.template_file.userdata.rendered}"
  key_name             = "aws"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "webELB" {
  name            = "webELB"
  subnets         = ["${aws_subnet.publicA.id}", "${aws_subnet.publicB.id}", "${aws_subnet.publicC.id}"]
  security_groups = ["${aws_default_security_group.default.id}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 5
  }

  tags {
    Name = "jenkins-elb"
  }
}

resource "aws_autoscaling_group" "webappASG" {
  name                 = "webappASG"
  max_size             = 1
  min_size             = 1
  desired_capacity     = 1
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.webappLC.name}"
  vpc_zone_identifier  = ["${aws_subnet.publicA.id}", "${aws_subnet.publicB.id}", "${aws_subnet.publicC.id}"]
  load_balancers       = ["${aws_elb.webELB.name}"]

  tags = [
    {
      key                 = "Name"
      value               = "webAppASG"
      propagate_at_launch = true
    },
  ]
}
