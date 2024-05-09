job "nginx" {
  datacenters = ["dc1"]
  group "web" {
    count = 1
    network {
      port "http" {
        static = 5000
        to = 80
      }
    }

     
    task "nginx" {
      driver = "docker"
      config {
        image = "nginx"
        ports = ["http"]
        volumes = [
          "/var/www/html:/usr/share/nginx/html:ro",
          "new/default.conf:/etc/nginx/nginx.conf:ro"  
        ]
      }
    }
  }
}