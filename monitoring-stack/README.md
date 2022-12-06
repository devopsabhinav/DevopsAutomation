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
             
`Charts/grafana/templates/service.yaml`

```console
spec:
{{- if (or (eq .Values.service.type "ClusterIP") (empty .Values.service.type)) }}
 type: NodePort

```
