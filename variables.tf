variable "container_name" {
  description = "Name of the Nginx container"
  type        = string
  default     = "terraform-nginx"
}

variable "host_port" {
  description = "Port exposed on the host machine"
  type        = number
  default     = 8080
}