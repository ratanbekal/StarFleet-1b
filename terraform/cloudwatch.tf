resource "aws_cloudwatch_log_group" "uss-enterprise" {
  name              = "/ecs/uss-enterprise"
  retention_in_days = 30
  tags {
    Name = "uss-enterprise"
  }
}
