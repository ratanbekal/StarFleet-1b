resource "aws_ecr_repository" "uss-enterprise" {
  name = "uss-enterprise"
}

output "uss-enterprise-repo" {
  value = "${aws_ecr_repository.uss-enterprise.repository_url}"
}
