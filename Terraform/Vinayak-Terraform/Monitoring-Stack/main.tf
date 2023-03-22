//---------------
#Loki Deploy in Cluster

resource "helm_release" "loki" {
  name = "loki"
  chart = "./loki"
  namespace  = "monitoring"
  create_namespace = true
  

  # set {
  #   name = "nodeSelector.pv"
  #   value = "monitoring"
  # }
  set {
    name = "persistence.enable"
    value = "true"
  }
  set {
    name = "persistence.size"
    value = "10Gi"
  }
  set {
    name = "promtail.enable"
    value = "true"
  }  
  set {
    name = "tableManager.retentionDeletesEnabled"
    value = "true"
  }
  set {
    name = "tableManager.retentionPeriod"
    value = "6d"
  }
}

//---------------
#KPS Deploy in Cluster

resource "helm_release" "kps" {
  name = "kps"
  chart = "./kube-prometheus-stack"
  namespace  = "monitoring"
  depends_on = [helm_release.loki]  

  set {
    name = "grafana.adminPassword"
    value = "f7qO80X8Oy7f"
  }
}  