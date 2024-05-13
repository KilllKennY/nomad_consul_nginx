job "nginx" {
  datacenters = ["dc1"]
  type = "service"

  group "cache" {
    count = 1

    task "nginx_task" {
      driver = "docker"
      config {
        image = "nginx:latest"
        mount {
          type = "bind"
          source = "local"
          terget = "/etc/nginx/"
        }
      }

      template {
        source        = "local/nginx.conf"
        destination   = "new/default.conf"
        change_mode   = "restart"
      }

      resources {
        network {
          mbits = 10
          port "nginx" {
            static = 5000
          }
        }
      }
    }
  }
}