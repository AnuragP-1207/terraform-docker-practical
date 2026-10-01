output "nginx_url" {
  description = "URL of the Nginx application"
  value       = "http://localhost:${var.host_port}"
}

output "network_name" {
  value = docker_network.app_network.name
}

output "volume_name" {
  value = docker_volume.redis_data.name
}

output "container_name" {
  value = docker_container.nginx.name
}