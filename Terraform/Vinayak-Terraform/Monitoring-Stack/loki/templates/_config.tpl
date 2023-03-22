{{/* vim: set filetype=mustache: */}}
{{- define "loki.config" -}}
target: {{ default "all" .Values.target | toString }}
auth_enabled: {{ default false .Values.authEnabled | toString }}
server:
  http_listen_address: 0.0.0.0
  http_listen_port: {{ .Values.server.httpPort | toString }}
  grpc_listen_address: 0.0.0.0
  grpc_listen_port: {{ .Values.server.grpcPort | toString }}
  register_instrumentation: true
  graceful_shutdown_timeout: {{ default "30s" .Values.server.gracefulShutdownTimeout | toString }}
  http_server_read_timeout: {{ default "30s" .Values.server.httpReadTimeout | toString }}
  http_server_write_timeout: {{ default "30s" .Values.server.httpWriteTimeout | toString }}
  http_server_idle_timeout: {{ default "120s" .Values.server.httpIdleTimeout | toString }}
  grpc_server_max_recv_msg_size: {{ default 4194304 .Values.server.grpcMaxRecvMsgSize | int64 | toString }}
  grpc_server_max_send_msg_size: {{ default 4194304 .Values.server.grpcMaxSendMsgSize | int64 | toString }}
  grpc_server_max_concurrent_streams: {{ default 100 .Values.server.grpcMaxConcurrentStreams | int64 | toString }}
  log_level: {{ .Values.logLevel | toString }}
  {{- if .httpPrefix }}
  http_prefix: {{ .httpPrefix | toString }}
  {{- end }}
{{- if .Values.distributor }}
distributor:
  {{- include "loki.distributorConfig" .Values.distributor | trim | nindent 2 }}
{{- end }}
{{- if .Values.querier }}
querier:
  {{- include "loki.querierConfig" .Values.querier | trim | nindent 2 }}
{{- end }}
{{- if .Values.frontend }}
frontend:
  {{- include "loki.frontendConfig" .Values.frontend | trim | nindent 2 }}
{{- end }}
{{- if .Values.queryRange }}
query_range:
  {{- include "loki.queryRangeConfig" .Values.queryRange | trim | nindent 2 }}
{{- end }}
{{- if .Values.ruler }}
ruler:
  {{- include "loki.rulerConfig" .Values.ruler | trim | nindent 2 }}
{{- end }}
{{- if .Values.ingesterClient }}
ingester_client:
  {{- include "loki.ingesterClientConfig" .Values.ingesterClient | trim | nindent 2 }}
{{- end }}
{{- if .Values.ingester }}
ingester:
  {{- include "loki.ingesterConfig" .Values.ingester | trim | nindent 2 }}
{{- end }}
{{- if .Values.compactor }}
compactor:
  {{- include "loki.compactorConfig" .Values.compactor | trim | nindent 2 }}
{{- end }}
{{- if .Values.storageConfig }}
storage_config:
  {{- include "loki.storageConfig" .Values.storageConfig | trim | nindent 2 }}
{{- end }}
{{- if .Values.chunkStoreConfig }}
chunk_store_config:
  {{- include "loki.chunkStoreConfig" .Values.chunkStoreConfig | trim | nindent 2 }}
{{- end }}
{{- if .Values.schemaConfig }}
schema_config:
  {{- include "loki.schemaConfig" .Values.schemaConfig | trim | nindent 2 }}
{{- end }}
{{- if .Values.limitsConfig }}
limits_config:
  {{- include "loki.limitsConfig" .Values.limitsConfig | trim | nindent 2 }}
{{- end }}
{{- if .Values.frontendWorker }}
frontend_worker:
  {{- include "loki.frontendWorkerConfig" .Values.frontendWorker | trim | nindent 2 }}
{{- end }}
{{- if .Values.tableManager }}
table_manager:
  {{- include "loki.tableManagerConfig" .Values.tableManager | trim | nindent 2 }}
{{- end }}
{{- if .Values.runtimeConfig.file }}
runtime_config:
  period: {{ default "10s" .Values.runtimeConfig.period | toString }}
  file: /configs/runtime.yaml
{{- end }}
{{- if .Values.tracing.enabled }}
tracing:
  enabled: {{ .Values.tracing.enabled | toString }}
{{- end }}
{{- end -}}
