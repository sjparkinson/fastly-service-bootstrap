resource "fastly_service_v1" "fastly_service_bootstrap" {
  // Origins.
  backend {
    name              = "domain www.example.com"
    address           = "www.example.com"
    port              = 443
    healthcheck       = "www.example.com"
    ssl_cert_hostname = "www.example.com"
  }

  healthcheck {
    name = "www.example.com"
    host = "www.example.com"
    path = "/"
  }
}
