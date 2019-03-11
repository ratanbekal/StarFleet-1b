resource "aws_alb" "uss-enterprise" {
  name = "uss-enterprise"
  internal = false

  security_groups = [
    "${aws_security_group.ecs.id}",
    "${aws_security_group.alb.id}",
  ]

  subnets = [
    "${module.base_vpc.public_subnets[0]}",
    "${module.base_vpc.public_subnets[1]}"
  ]
}

resource "aws_alb_target_group" "uss-enterprise" {
  name = "uss-enterprise"
  protocol = "HTTP"
  port = "3000"
  vpc_id = "${module.base_vpc.vpc_id}"
  target_type = "ip"

  health_check {
    path = "/"
  }
}

resource "aws_alb_listener" "uss-enterprise" {
  load_balancer_arn = "${aws_alb.uss-enterprise.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.uss-enterprise.arn}"
    type = "forward"
  }

  depends_on = ["aws_alb_target_group.uss-enterprise"]
}


output "alb_dns_name" {
  value = "${aws_alb.uss-enterprise.dns_name}"
}
