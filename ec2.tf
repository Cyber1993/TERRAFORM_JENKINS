provider "aws" {
  region = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "nmd221" {
  availability_zone = "eu-central-1a"
  ami = "ami-0faab6bdbac9486fb"
  instance_type = "t2.micro"
  key_name = "221Frankfurt"
  vpc_security_group_ids = [aws_security_group.nmd221.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 15
    volume_type = "standard"
  }
  user_data = file("install.sh")
  //user_data = file("${path.module}/install.sh")
  //user_data = <<-EOF
  //           #!/bin/bash
  //          sudo apt-get update -y
  //           sudo apt-get install apache2 -y
  //           sudo systemctl start apache2
  //          sudo systemctl enable apache2
  //           EOF
  tags = {
    Name = "EC2-instance"
  }
}

resource "aws_security_group" "nmd221" {
  name        = "nmd221"
  description = "Allow 22, 80 inbound taffic"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
