resource "aws_security_group" "ecs-service" {
  name = "koko"
}

variable "name" {
  type = string
}

output "name" {
  value = "dupa"
}
