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

## Changes to be made in KPS Helm Charts according project's
