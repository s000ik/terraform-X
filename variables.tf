variable "instance_name" {
  description = "value of the Name tag for the EC2 instance"
  type        = string
  default     = "MyInstance"
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}
