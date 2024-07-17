resource "argocd_application" "helm" {
  metadata {
    name        = "helm-app-using-terraform"
    namespace   = "argocd"
    annotations = {
      "notifications.argoproj.io/subscribe.on-deployed.slack" = "argocd"
    }
    labels = {
      test = "true"
    }
  }

  spec {
    project = "default"

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }

    source {
      repo_url        = "https://github.com/motrabelsi10/med.git"
      path            = "mychart"
      target_revision = "main"
      helm {
        release_name = "my-release"
        value_files  = []
      }
    }

    sync_policy {
      automated {
        prune    = true
        self_heal = true
      }
    }
  }
}
