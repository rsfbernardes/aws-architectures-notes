# Exemplo simples de Terraform para EC2 + EBS (resumido)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0abcdef1234567890" # substitua pela AMI da sua região
  instance_type = "t3.micro"
  subnet_id     = "subnet-0123456789abcdef0" # opcional
  tags = {
    Name = "lab-ec2-ebs"
  }
  user_data = file("${path.module}/../scripts/ec2_user_data.sh")
}

resource "aws_ebs_volume" "data" {
  availability_zone = aws_instance.example.availability_zone
  size              = 20
  type              = "gp3"
  tags = {
    Name = "lab-ebs"
  }
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.example.id
}