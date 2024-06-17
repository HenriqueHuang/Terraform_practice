# VPC
variable "vpc_name" {
  type = string
  default = "my_vpc"
  description = "Name of VPC"
}
variable "vpc_cidr" {
  type = string
  default = "172.16.0.0/16"
}
variable "subnet_name" {
  type = string
  default = "my_subnet"
}

#Inboud rules
variable "ingress" {
  type = string
  default = "ingress"
}
variable "IPv4" {
  type = string
  default = "IPv4"
}
variable "tcp" {
  type = string
  default = "tcp"
}
variable "remote_ip_prefix" {
  type = string
  default = "0.0.0.0/0"
}

variable "my_pass" {
  type = string
  default = "hu@wei753"
}


