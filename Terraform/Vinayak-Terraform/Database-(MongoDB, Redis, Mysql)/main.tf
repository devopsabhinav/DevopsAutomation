//----------------------------------------------------------------------------------------------------------------------------------------
#MongoDB Deploy in Cluster

resource "helm_release" "mongodb" {
  name       = "mongodb-dev-test"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
#   version    = "v13.9.2"
  namespace  = "dev"
  create_namespace = true
  
  set {
    name  = "architecture"
    value = "replicaset"      #`standalone` or `replicaset`
  }

  set {
    name  = "replicaCount"
    value = "2"     
  }  

  set {
    name  = "auth.rootPassword"
    value = "MQ0Roi18u5X9"    
  }

  set {
    name  = "persistence.size"
    value = "10Gi"     #`standalone` or `replicaset`
  }

#   set {
#     name = "nodeSelector.mongodb"
#     value = "mongo-db-ap-south-1b"
#   }

  set {
    name  = "livenessProbe.enabled"
    value = "false"
  }

  set {
    name  = "readinessProbe.enabled"
    value = "false"
  }

#   set {
#     name  = "arbiter.nodeSelector.mongodb"
#     value = "mongo-db-ap-south-1b"
#   }

  set {
    name  = "arbiter.livenessProbe.enabled"
    value = "false"
  }

  set {
    name  = "arbiter.readinessProbe.enabled"
    value = "false"
  }
}

//----------------------------------------------------------------------------------------------------------------------------------------
#Mysql Deploy in Cluster

resource "helm_release" "mysql" {
  name       = "mysql-dev-test"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"
#   version    = "v9.7.0"
  namespace  = "dev"

  set {
    name  = "auth.rootPassword"
    value = "3GDK3epZBh1t"
  }
  set {
    name  = "auth.username"
    value = "admin"
  }

  set {
    name  = "auth.password"
    value = "aHe2mX383Owl"
  } 

  set {
    name  = "architecture"
    value = "replication"      #`standalone` or `replication`
  }
  
  set {
    name  = "secondary.replicaCount"
    value = "1"
  }

  set {
    name  = "primary.persistence.size"
    value = "10Gi"
  }

  set {
    name  = "secondary.persistence.size"
    value = "10Gi"
  }

  # set {
  #   name  = "primary.nodeSelector.mysqldevpv"
  #   value = "apsouth1a"
  # }

  # set {
  #   name  = "secondary.nodeSelector.mysqldevpv"
  #   value = "apsouth1a"
  # }
}

//----------------------------------------------------------------------------------------------------------------------------------------
#Redis Deploy in Cluster

resource "helm_release" "redis" {
  name       = "redis-dev-test"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
#   version    = "v17.9.1"
  namespace  = "dev"

  set {
    name  = "auth.enabled"
    value = "false"
  }

  set {
    name  = "architecture"
    value = "replication"      #`standalone` or `replication`
  }

  set {
    name  = "master.count"
    value = "1"
  }
  
  set {
    name  = "replica.replicaCount"
    value = "1"
  }

  # set {
  #   name  = "master.nodeSelector.mysqldevpv"
  #   value = "apsouth1a"
  # }

  # set {
  #   name  = "replica.nodeSelector.mysqldevpv"
  #   value = "apsouth1a"
  # }

  set {
    name  = "master.persistence.size"
    value = "8Gi"
  }

  set {
    name  = "replica.persistence.size"
    value = "8Gi"
  } 
}