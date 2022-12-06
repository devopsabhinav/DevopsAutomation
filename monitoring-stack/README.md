## Changes to be made in Loki Helm Charts according project's

`values.yaml`

```console
nodeSelector:
  pv: "monitoring"

persistence:
  enabled: true
  storageClassName: ""
  size: 10Gi
  accessModes: [ ReadWriteOnce ]
  volumeMode: Filesystem

promtail:
  enabled: true

tableManager:
  retentionDeletesEnabled: true
  retentionPeriod: 6d
```

## Changes to be made in kube-prometheus-stack Helm Charts according project's

`Main Values.yaml `

```console
   additionalScrapeConfigs:
     - job_name: fantasy-node-dev-pm2-metrics
       scrape_interval: 10s
       scrape_timeout: 10s
       metrics_path: /metrics
       scheme: http
       static_configs:
         - targets:
             - fantasy-node-dev-pm2.dev.svc.cluster.local:9209
             
```
             
`Grafana Charts/grafana/templates/service.yaml`

```console
spec:
{{- if (or (eq .Values.service.type "ClusterIP") (empty .Values.service.type)) }}
 type: NodePort

```

`Grafana Charts/grafana/values.yaml`

```console
persistence:
 type: pvc
 enabled: true
 
env:
 GF_SMTP_ENABLED: "true"
 GF_SMTP_HOST: "smtp.gmail.com:587"
 GF_SMTP_USER: "support@yudiz.com"
 GF_SMTP_PASSWORD: "Yudiz@2022"
 
envValueFrom: {}

datasources:
datasources.yaml:
  apiVersion: 1
  datasources:
  - name: Loki
    type: loki
    url: http://loki
  - name: CloudWatch
    type: cloudwatch
    jsonData:
      authType: keys
      defaultRegion: ap-south-1
    secureJsonData:
      accessKey: 'accesskey'
      secretKey: 'secretkey'
      
dashboardProviders:
dashboardproviders.yaml:
  apiVersion: 1
  providers:
  - name: 'default'
    orgId: 1
    folder: ''
    type: file
    disableDeletion: false
    editable: true
    options:
      path: /var/lib/grafana/dashboards/default

dashboards:
 default:
 #   some-dashboard:
 #     json: |
 #       $RAW_JSON
 #   custom-dashboard:
 #     file: dashboards/custom-dashboard.json
   pm2-dashboard:
     gnetId: 12745
     datasource: Prometheus
   loki-dashboard:
     gnetId: 13639
     datasource: Loki
   alb-dashboard:
     gnetId: 14361
     datasource: CloudWatch
 #   prometheus-stats:
 #     gnetId: 2
 #     revision: 2
 #     datasource: Prometheus

```
