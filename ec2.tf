provider "aws" {
  region = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "nmd221" {
  availability_zone = "eu-north-1a"
  ami = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "221"
  vpc_security_group_ids = [aws_security_group.default.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 15
    volume_type = "standard"
  }
  //user_data = file("install.sh")
  //user_data = file("${path.module}/install.sh")
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF
  tags = {
    Name = "EC2-instance"
  }
}

resource "aws_security_group" "nmd221" {
  ingress{
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "Allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
