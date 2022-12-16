module "m1" {
  for_each = local.environments
  source   = "./m"
  name     = module.m2[each.key].name
}


module "m2" {
  for_each = local.environments
  source   = "./m"
  name     = aws_secretsmanager_secret_version.connection_details[each.key].arn
}


resource "aws_secretsmanager_secret" "connection_details" {
  for_each = local.environments
  name     = "superset-co"
}

resource "aws_secretsmanager_secret_version" "connection_details" {
  for_each  = local.environments
  secret_id = aws_secretsmanager_secret.connection_details[each.key].id
  secret_string = jsonencode(
    {
      MODULE_NAME = module.m1[*].name
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
