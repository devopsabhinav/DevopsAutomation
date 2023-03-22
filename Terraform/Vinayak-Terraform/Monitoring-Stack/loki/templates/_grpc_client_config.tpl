{{/* vim: set filetype=mustache: */}}
{{- define "loki.grpcClientConfig" -}}
max_recv_msg_size: {{ default 104857600 .maxRecvMsgSize | int64 | toString }}
max_send_msg_size: {{ default 16777216 .maxSendMsgSize | int64 | toString }}
{{- if .grpcCompression }}
grpc_compression: {{ .grpcCompression }}
{{- end }}
rate_limit: {{ default 0 .rateLimit | int64 | toString }}
rate_limit_burst: {{ default 0 .rateLimitBurst | int64 | toString }}
backoff_on_ratelimits: {{ default false .backoffOnRatelimits | toString }}
{{- if and (eq .backoffOnRatelimits true) .backoffConfig }}
backoff_config:
  min_period: {{ default "100ms" .backoffConfig.minPeriod | toString }}
  max_period: {{ default "10s" .backoffConfig.maxPeriod | toString }}
  max_retries: {{ default 10 .backoffConfig.maxRetries | int64 | toString }}
{{- end }}
{{- end -}}
