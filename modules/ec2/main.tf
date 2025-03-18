# EC2 Module
resource "aws_instance" "sp_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_pair_name

  tags = {
    Name = "sp-instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.sp_instance.public_ip
}

variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "key_pair_name" {}
variable "security_group_id" {}
