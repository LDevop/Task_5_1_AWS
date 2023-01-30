variable "aws_region" {
  default     = "eu-central-1"
  description = "aws region where our resources going to create choose"
  #replace the region as suits for your requirement
}

variable "az_public" {
  default = ["eu-central-1a", "eu-central-1b"]
  #type = "list"
}

variable "az_private" {
  default = "eu-central-1c"
}

variable "subnet_cidrs_public" {
  default = ["192.168.2.0/24", "192.168.0.0/24"]
}

variable "subnet_cidr_private" {
  default = "192.168.1.0/24"
}

variable "ssh_location" {
  type        = string
  description = "My Public IP Address"
  default     = "1.2.3.4/32"
}

variable "ami" {
  default = "ami-0039da1f3917fa8e3"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_rds" {
  default = ["192.168.3.0/24", "192.168.4.0/24"]

}
variable "az_rds" {
  default = ["eu-central-1c", "eu-central-1b"]
}

variable "subnet_cidrs" {
  default = ["192.168.3.0/24", "192.168.4.0/24", "192.168.2.0/24", "192.168.0.0/24", "192.168.1.0/24"]
}