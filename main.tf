terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "app_network" {
  name = "terraform_app_network"
}

resource "docker_volume" "redis_data" {
  name = "terraform_redis_data"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "redis" {
  name = "redis:7-alpine"
}

resource "docker_container" "redis" {
  name  = "terraform-redis"
  image = docker_image.redis.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  mounts {
    type   = "volume"
    target = "/data"
    source = docker_volume.redis_data.name
  }
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.host_port
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.redis]
}