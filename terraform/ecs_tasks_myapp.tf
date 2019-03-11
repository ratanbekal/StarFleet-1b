data "template_file" "uss-enterprise" {
  template = "${file("templates/ecs/uss-enterprise.json.tpl")}"
  vars {
    REPOSITORY_URL = "${aws_ecr_repository.uss-enterprise.repository_url}"
    AWS_REGION = "${var.AWS_REGION}"
    LOGS_GROUP = "${aws_cloudwatch_log_group.uss-enterprise.name}"
  }
}

resource "aws_ecs_task_definition" "uss-enterprise" {
  family                = "uss-enterprise"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = "${data.template_file.uss-enterprise.rendered}"
  execution_role_arn = "${aws_iam_role.ecs_task_assume.arn}"
}

resource "aws_ecs_service" "uss-enterprise" {
  name            = "uss-enterprise"
  cluster         = "${aws_ecs_cluster.fargate.id}"
  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.uss-enterprise.arn}"
  desired_count   = 1

  network_configuration = {
    subnets = ["${module.base_vpc.private_subnets[0]}"]
    security_groups = ["${aws_security_group.ecs.id}"]
  }

  load_balancer {
   target_group_arn = "${aws_alb_target_group.uss-enterprise.arn}"
   container_name = "uss-enterprise"
   container_port = 3000
  }

  depends_on = [
    "aws_alb_listener.uss-enterprise"
  ]
}
