terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  access_key = "AKIA4TQLZMAMXQPITUER"
  secret_key = "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"
}

# Create a VPC
resource "aws_vpc" "ciscolive" {
  cidr_block = "10.1.0.0/16"

  tags = {
	Name = "ciscolive-pod1"
  }

}

resource "aws_subnet" "ciscolive" {
  vpc_id     = aws_vpc.ciscolive.id
  cidr_block = "10.1.0.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "cisco-live-pod1"
  }
}



resource "aws_instance" "ciscolive" {

  ami           = "ami-0359b3157f016ae46" # us-west-2
  instance_type = "t2.micro"
  subnet_id = aws_subnet.ciscolive.id
  key_name = "ciscolive"
  tags = {
    Name = "ciscolive-pod1"
  }

}
