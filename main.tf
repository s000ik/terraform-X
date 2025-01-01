# Resource Block
resource "aws_instance" "myec2" {
  ami = "ami-0fd05997b4dff7aac" # Amazon Linux 2023 AMI x86
  instance_type = var.ec2_instance_type
  tags = {
    Name = var.instance_name
    }
}