{{/* vim: set filetype=mustache: */}}
{{- define "loki.tableManagerConfig" -}}
throughput_updates_disabled: {{ default false .throughputUpdatesDisabled | toString }}
retention_deletes_enabled: {{ default false .retentionDeletesEnabled | toString }}
retention_period: {{ default "0s" .retentionPeriod | toString }}
poll_interval: {{ default "2m" .pollInterval | toString }}
creation_grace_period: {{ default "10m" .creationGracePeriod | toString }}
{{- if .indexTablesProvisioning }}
index_tables_provisioning:
  {{- include "loki.provisionConfig" .indexTablesProvisioning | trim | nindent 2 }}
{{- end }}
{{- if .chunkTablesProvisioning }}
chunk_tables_provisioning:
  {{- include "loki.provisionConfig" .chunkTablesProvisioning | trim | nindent 2 }}
{{- end }}
{{- end -}}
