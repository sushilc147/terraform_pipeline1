variable "accessKey" {
  type        = string
  description = "AWS access key id"
  default = "missing"
}

variable "secretKey" {
  type        = string
  description = "AWS access secret key"
  default = "missing"
}
# Use AWS Terraform provider
provider "aws" {
  access_key = "{var.accessKey}"
  secret_key = "{var.secretKey}"
  region     = "us-east-2"
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = var.ami
  count                  = var.instance_count
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "terraform-default"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
