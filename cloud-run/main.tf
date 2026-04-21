resource "google_cloud_run_v2_service" "default" {
  name     = "mcp-wikipedia-service"
  location = "us-central1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  scaling {
    max_instance_count = 100
  }

  template {
    containers {
      image = "mcp/wikipedia-mcp"
      ports {
        container_port = 8080
      }
      args = ["--transport","sse","--host","0.0.0.0" ,"--port", "8080" ]
    }
    
  }
}

output "cloud_run_url" {
  value = google_cloud_run_v2_service.default.uri
}