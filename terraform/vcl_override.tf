resource "fastly_service_v1" "fastly_service_bootstrap" {
  vcl {
    name    = "main.vcl"
    content = "${file("${path.module}/../vcl/main.vcl")}"
    main    = true
  }

  vcl {
    name    = "fastly-boilerplate.vcl"
    content = "${file("${path.module}/../vcl/fastly-boilerplate.vcl")}"
  }

  vcl {
    name    = "redirect-https.vcl"
    content = "${file("${path.module}/../vcl/redirect-https.vcl")}"
  }

  vcl {
    name    = "synth-gtg.vcl"
    content = "${file("${path.module}/../vcl/synth-gtg.vcl")}"
  }
}
