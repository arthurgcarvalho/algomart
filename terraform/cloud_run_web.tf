resource "google_cloud_run_service" "web" {
  name     = var.web_service_name
  location = var.region

  autogenerate_revision_name = false

  template {
    metadata {
      name = "${var.web_revision_name}-${random_integer.random-integer.result}"
    }

    spec {
      containers {
        image = data.google_secret_manager_secret_version.web_image.secret_data

        env {
          name  = "API_KEY"
          value = data.google_secret_manager_secret_version.api_key.secret_data
        }
/*
        env {
          name  = "API_URL"
          value = "https://${var.api_domain_mapping}"
        }
*/
        env {
          name  = "FIREBASE_SERVICE_ACCOUNT"
          value = data.google_secret_manager_secret_version.web-firebase-service-account.secret_data
        }

        env {
          name  = "IMAGE_DOMAINS"
          value = "lh3.googleusercontent.com,firebasestorage.googleapis.com,"//${var.cms_domain_mapping}"
        }

        env {
          name  = "NEXT_PUBLIC_3JS_DEBUG"
          value = var.web_next_public_3js_debug
        }

        env {
          name  = "NEXT_PUBLIC_FIREBASE_CONFIG"
          value = data.google_secret_manager_secret_version.web_next_public_firebase_config.secret_data
        }

        env {
          name  = "NODE_ENV"
          value = var.web_node_env
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    google_project_service.run_api,
  ]
}
/*
resource "google_cloud_run_domain_mapping" "web" {
  location = var.region
  name     = var.web_domain_mapping

  metadata {
    namespace = var.project
  }

  spec {
    route_name = google_cloud_run_service.web.name
  }
}
*/
resource "google_cloud_run_service_iam_member" "web_all_users" {
  service  = google_cloud_run_service.web.name
  location = google_cloud_run_service.web.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
