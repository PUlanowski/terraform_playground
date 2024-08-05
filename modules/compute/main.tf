resource "google_compute_instance_group_manager" "web_instance_group_manager" {
  name               = "web-instance-group-manager"
  version            = {
    instance_template = google_compute_instance_template.web_instance_template.id
  }
  base_instance_name = "web-instance"
  target_size        = var.instance_count
  zone               = var.zone
  wait_for_instances  = true
}

resource "google_compute_instance_template" "web_instance_template" {
  name          = "web-instance-template"
  machine_type  = var.machine_type
  network       = var.network_name
  subnetwork    = var.subnetwork_name

  disk {
    auto_delete = true
    boot        = true
    source_image = "projects/debian-cloud/global/images/family/debian-11"
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
  EOT
}

resource "google_compute_global_forwarding_rule" "web_forwarding_rule" {
  name       = "web-forwarding-rule"
  target     = google_compute_target_http_proxy.web_target_proxy.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "web_target_proxy" {
  name    = "web-target-proxy"
  url_map = google_compute_url_map.web_url_map.id
}

resource "google_compute_url_map" "web_url_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.web_backend_service.id
}

resource "google_compute_backend_service" "web_backend_service" {
  name          = "web-backend-service"
  protocol      = "HTTP"
  backends {
    group = google_compute_instance_group_manager.web_instance_group_manager.instance_group
  }
  health_checks = [google_compute_http_health_check.web_health_check.id]
}

resource "google_compute_http_health_check" "web_health_check" {
  name               = "web-health-check"
  request_path       = "/"
  port               = 80
  check_interval_sec = 10
  timeout_sec        = 10
  healthy_threshold  = 2
  unhealthy_threshold = 2
}
