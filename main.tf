resource "fastly_service_v1" "fastly_service_bootstrap" {
  // Our example service.
  name         = "Fastly Service Bootstrap"
  default_host = "www.example.com"

  domain {
    name    = "blue-frost-1016.ft.com"
    comment = "An example domain."
  }

  // Enable gzip compression of responses.
  gzip {
    name = "Default Gzip Policy"

    // Fastly's default extensions to compress.
    extensions = ["css", "js", "html", "eot", "ico", "otf", "ttf", "json", "svg"]

    // Fastly's default content types to compress.
    content_types = ["text/html", "application/x-javascript", "text/css", "application/javascript", "text/javascript", "application/json", "application/vnd.ms-fontobject", "application/x-font-opentype", "application/x-font-truetype", "application/x-font-ttf", "application/xml", "font/eot", "font/opentype", "font/otf", "image/svg+xml", "image/vnd.microsoft.icon", "text/plain", "text/xml"]
  }

  // Origins.
  backend {
    name              = "addr www.example.com"
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

  // Custom VCL.
  vcl {
    name    = "main.vcl"
    content = "${file("${path.module}/vcl/main.vcl")}"
    main    = true
  }

  vcl {
    name    = "fastly-boilerplate.vcl"
    content = "${file("${path.module}/vcl/fastly-boilerplate.vcl")}"
  }

  vcl {
    name    = "redirect-https.vcl"
    content = "${file("${path.module}/vcl/redirect-https.vcl")}"
  }

  vcl {
    name    = "synth-gtg.vcl"
    content = "${file("${path.module}/vcl/synth-gtg.vcl")}"
  }
}
