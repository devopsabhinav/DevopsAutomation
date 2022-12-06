{{/* vim: set filetype=mustache: */}}
{{- define "loki.frontendWorkerConfig" -}}
{{- if .frontendAddress }}
frontend_address: {{ .frontendAddress | toString }}
{{- end }}
parallelism: {{ default 10 .parallelism | int64 | toString }}
dns_lookup_duration: {{ default "10s" .dnsLookupDuration | toString }}
grpc_client_config:
  {{- include "loki.grpcClientConfig" .grpcClientConfig | trim | nindent 2 }}
{{- end -}}
