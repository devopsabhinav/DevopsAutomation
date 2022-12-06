## Changes made in this Helm Charts

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
