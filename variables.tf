variable "gcp_project" {
    type = number
}

variable "gcp_region" {
    type = string
}

variable "vpc_network" {
  type = list(string)
}

variable "subnet_webapp" {
  type = list(string)
}

variable "subnet_webapp_ip_cidr" {
  type = list(string)
}

variable "subnet_webapp_route_name" {
  type = list(string)
}

variable "subnet_webapp_route" {
  type = string
}

variable "subnet_db" {
  type = list(string)
}

variable "subnet_db_ip_cidr" {
  type = list(string)
}