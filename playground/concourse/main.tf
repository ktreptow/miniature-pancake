provider "aws" {
  region = "eu-central-1"
}

variable "public_key" {}

module "concourse" {
  source = "../../modules/concourse"

  public_key = var.public_key

  prefix = "oct12000"
  instances_prefix = formatdate("DD-MMM-YY", timestamp())
  
  worker = {
    instance_type        = "t3.micro"
    min                  = 1
    max                  = 1
    desired              = 1
    environment_override = {}
  }

  web = {
    instance_type        = "t2.micro"
    min                  = 1
    max                  = 1
    desired              = 1
    environment_override = {}
  }

  # module.my_module.some_output_name
  # web = {
  #   instance_type = "t2.micro"
  # }
}
