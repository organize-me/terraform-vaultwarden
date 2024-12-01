resource "docker_image" "fake_smtp" {
  name = "reachfive/fake-smtp-server:0.8.1"
}

resource "docker_container" "fake_smtp" {
  name  = "test-fake-smtp"
  image = docker_image.fake_smtp.image_id
  network_mode = "bridge"

  // SMTP port
  ports {
    internal = 1025
    external = var.smtp_port
  }

  command = ["node", "index.js", "--debug", "--auth", "${var.smtp_username}:${var.smtp_password}"]

  // HTTP port
  ports {
    internal = 1080
    external = 1080
  }

  networks_advanced {
    name = docker_network.network.name
  }

  # Configures advanced network settings for the PostgreSQL container.
  networks_advanced {
    name = docker_network.network.name
    aliases = ["smtp"]
  }
}