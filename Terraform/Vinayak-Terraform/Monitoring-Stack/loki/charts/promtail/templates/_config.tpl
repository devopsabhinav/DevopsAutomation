{{/* vim: set filetype=mustache: */}}
{{- define "promtail.positionsPath" -}}
{{- default "/run/promtail/positions.yaml" .Values.positionsPath -}}
{{- end -}}

{{- define "promtail.positionsDirectory" -}}
{{- include "promtail.positionsPath" . | dir -}}
{{- end -}}

{{- define "promtail.config" -}}
server:
  http_listen_address: 0.0.0.0
  http_listen_port: {{ .Values.server.httpPort | int64 | toString }}
  grpc_listen_address: 0.0.0.0
  grpc_listen_port: {{ .Values.server.grpcPort | int64 | toString }}
  graceful_shutdown_timeout: {{ .Values.server.gracefulShutdownTimeout | toString }}
  http_server_read_timeout: {{ .Values.server.httpReadTimeout | toString }}
  http_server_write_timeout: {{ .Values.server.httpWriteTimeout | toString }}
  http_server_idle_timeout: {{ .Values.server.httpIdleTimeout | toString }}
  grpc_server_max_recv_msg_size: {{ .Values.server.grpcMaxRecvMsgSize | int64 | toString }}
  grpc_server_max_send_msg_size: {{ .Values.server.grpcMaxSendMsgSize | int64 | toString }}
  grpc_server_max_concurrent_streams: {{ .Values.server.grpcMaxConcurrentStreams | int64 | toString }}
  log_level: {{ .Values.logLevel | toString }}
  http_path_prefix: {{ .Values.server.httpPathPrefix | toString }}
  health_check_target: {{ .Values.server.healthCheckTarget | toString }}

clients:
  - url: {{ .Values.lokiUrl | toString }}
    {{- if .Values.tenantId }}
    tenant_id: {{ .Values.tenantId | toString }}
    {{- end }}
    {{- with .Values.client }}
    batchwait: {{ .batchwait | toString }}
    batchsize: {{ .batchsize | int64 | toString }}
    {{-   if or .basicAuth.username .basicAuth.password .basicAuth.passwordFile }}
    basic_auth:
      username: {{ .basicAuth.username | toString }}
      password: {{ .basicAuth.password | toString }}
      password_file: {{ .basicAuth.passwordFile | toString }}
    {{-   end }}
    {{- if .bearerToken }}
    bearer_token: {{ .bearerToken | toString }}
    {{- end }}
    {{- if .bearerTokenFile }}
    bearer_token_file: {{ .bearerTokenFile | toString }}
    {{- end }}
    {{- if .proxyUrl }}
    proxy_url: {{ .proxyUrl | toString }}
    {{- end }}
    tls_config:
      ca_file: {{ .tls.caFile | toString }}
      cert_file: {{ .tls.certFile | toString }}
      key_file: {{ .tls.keyFile | toString }}
      server_name: {{ .tls.serverName | toString }}
      insecure_skip_verify: {{ .insecureSkipVerify }}
    backoff_config:
      min_period: {{ .backoffConfig.minPeriod | toString }}
      max_period: {{ .backoffConfig.maxPeriod | toString }}
      max_retries: {{ .backoffConfig.maxRetries | int64 | toString }}
    timeout: {{ .timeout | toString }}
    {{- end }}
  {{- with .Values.extraClientConfigs }}
  {{- toYaml . | nindent 2 }}
  {{- end }}

scrape_configs:
  {{- if .Values.pods.scrape }}
  {{-   include "promtail.scrapePods" . | trim | nindent 2 }}
  {{- end }}
  {{- if .Values.systemJournal.scrape }}
  {{-   include "promtail.scrapeSystemJournal" . | trim | nindent 2 }}
  {{- end }}
  {{- if .Values.auditLog.scrape }}
  {{-   include "promtail.scrapeAuditLog" . | trim | nindent 2 }}
  {{- end }}
  {{- if .Values.syslog.listen }}
  {{-   include "promtail.syslog" . | trim | nindent 2 }}
  {{- end }}
  {{- with .Values.extraScrapeConfigs }}
  {{- toYaml . | nindent 2 }}
  {{- end }}

positions:
  filename: {{ include "promtail.positionsPath" . }}
  sync_period: 10s
  ignore_invalid_yaml: false

target_config:
  sync_period: 10s
{{- end -}}
