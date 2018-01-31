#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-66506c1c
#
# Your subnet ID is:
#
#     subnet-849ca4cf
#
# Your security group ID is:
#
#     sg-3ee83749
#
# Your Identity is:
#
#     customer-training-puma
#
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

variable "num_webs" {
  default = "2"
}

resource "aws_instance" "web" {
  ami                    = "ami-66506c1c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-849ca4cf"
  vpc_security_group_ids = ["sg-3ee83749"]

  tags {
    "Identity" = "customer-training-puma"
    "tag1"     = "yourmom"
    "tag2"     = "yourgrandma"
    "Name"     = "web ${count.index + 1}/${var.num_webs}"
  }

  count = 2
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

#module "example" {
#  source  = "./example-module"
#  command = "echo your mom says hello"
#}

terraform {
  backend "atlas" {
    name = "seidenbt/training"
  }
}
