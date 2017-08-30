resource "fastly_service_v1" "fastly_service_bootstrap" {
  domain {
    name    = "blue-frost-1016.ft.com"
    comment = "An example domain."
  }
}
