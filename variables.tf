variable "region" {
  default = "us-west-2"
}
variable "stage" {
  default = "dev"
}

variable "network_address" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type      = list(string)
  default   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type      = list(string)
  default   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] 
}

variable "desired_nodes" {
  type    = number
  default = 4
}

variable "max_nodes" {
  type    = number
  default = 20
}

variable "min_nodes" {
  type    = number
  default = 4
}

variable "instance_type" {
  default = "t2.micro"
}





