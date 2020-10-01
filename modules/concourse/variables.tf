variable "public_key" {}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.10.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.10.10.0/24"
}
variable "worker" {
  description = "worker configuration options"
  type = object({
    instance_type = string
    min             = number
    max             = number
    desired         = number
    environment_override = map(string)
  })
  default = {
    instance_type = "t3.micro"
    min         = 2
    max         = 4
    desired     = 3
    environment_override = {}
  }
}
variable "web" {
  description = "atc/tsa configuration options"
  type = object({
    instance_type = string
    min             = number
    max             = number
    desired         = number
    environment_override = map(string)
  })
  default = {
    instance_type = "t2.micro"
    min             = 1
    max             = 4
    desired         = 2
    environment_override = {}
  }
}
variable "prefix" {
  description = "prefix of the application"
  default = "concourse"
}
variable "concourse_version" {
  default     = " 6.5.0"
  description = "The image name for concourse. Defaults to latest, but you should lock this down."
}
variable "aws_region" {
  default = "eu-central-1"
}
variable "aws_ami_id" {
  description = "AMI id for worker and web EC2 instances"
  default     = ""
}