provider "aws" {
  region                  = "us-east-1"
}

resource "aws_instance" "minecraft" {
  ami                    = "ami-02457590d33d576c3"
  instance_type          = "t2.micro"
  key_name               = "wordpress"         
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  tags = {
    Name = "minecraft-server"
  }
}

resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "minecraft security group"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
