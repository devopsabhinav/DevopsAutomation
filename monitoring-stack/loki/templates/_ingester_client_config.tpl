{{/* vim: set filetype=mustache: */}}
{{- define "loki.ingesterClientConfig" -}}
{{- if .poolConfig }}
pool_config:
  health_check_ingesters: {{ default false .poolConfig.healthCheckIngesters | toString }}
  client_cleanup_period: {{ default "15s" .poolConfig.clientCleanupPeriod | toString }}
{{- end }}
remote_timeout: {{ default "5s" .remoteTimeout | toString }}
{{- if .grpcClientConfig }}
grpc_client_config:
  {{- include "loki.grpcClientConfig" .grpcClientConfig | trim | nindent 2 }}
{{- end }}
{{- end -}}
