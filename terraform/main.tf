resource "argocd_application" "helm" {
  metadata {
    name      = "helm-app-using-terraform"
    namespace = "argocd"
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
    secret_ref {
      secret_name = "test-private-repo"
      namespace   = "argocd"
      }
    sync_policy {
      automated {
        prune    = true
        self_heal = true
      }
    }
  }
}
