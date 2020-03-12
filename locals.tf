locals {
  cluster_name                  = format("%s-eks", "${var.stage}")
  k8s_service_account_namespace = "kube-system"
  k8s_service_account_name      = "cluster-autoscaler"
}