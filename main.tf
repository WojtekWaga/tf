module "m1" {
  source = "./m"
  name   = module.m2.name
}


module "m2" {
  source = "./m"
  name   = aws_secretsmanager_secret_version.connection_details.arn
}


resource "aws_secretsmanager_secret" "connection_details" {
  name = "superset-co"
}

resource "aws_secretsmanager_secret_version" "connection_details" {
  secret_id = aws_secretsmanager_secret.connection_details.id
  secret_string = jsonencode(
    {
      MODULE_NAME = module.m1.name
    }
  )
}

locals {
  environments = {
    "dev" = "dev"
  }
}

/*
arn - The ARN of the secret.
id - A pipe delimited combination of secret ID and version ID.
version_id - The unique identifier of the version of the secret.
*/
