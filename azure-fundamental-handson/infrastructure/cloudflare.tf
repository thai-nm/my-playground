resource "cloudflare_cloud_connector_rules" "example_cloud_connector_rules" {
  zone_id = local.cloudflare_zone_id
  rules = [{
    description = "AFH Static Website"
    enabled = true
    expression = "http.request.full_uri wildcard \"http*://www.thainm-playground.site/*\")"
    parameters = {
      host = "afh.z23.web.core.windows.net"
    }
    cloud_provider = "azure_storage"
  }]
}