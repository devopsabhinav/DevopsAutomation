{{/* vim: set filetype=mustache: */}}
{{- define "loki.rulerConfig" -}}
{{- if .externalUrl }}
external_url: {{ .externalUrl | toString }}
{{- end }}
flush_period: {{ default "1m" .flushPeriod | toString }}
enable_api: {{ default false .enableApi | toString }}
evaluation_interval: {{ default "1m" .evaluationInterval | toString }}
poll_interval: {{ default "1m" .pollInterval | toString }}
rule_path: {{ default "/rules/groups.yaml" .rulePath | toString }}
{{- if .alertmanagerUrl }}
alertmanager_url: {{ .alertmanagerUrl | toString }}
{{- end }}
enable_alertmanager_discovery: {{ default false .enableAlertmanagerDiscovery | toString }}
alertmanager_refresh_interval: {{ default "1m" .alertmanagerRefreshInterval | toString }}
enable_alertmanager_v2: {{ default false .enableAlertmanagerV2 | toString }}
notification_queue_capacity: {{ default 10000 .notificationQueueCapacity | int64 | toString }}
notification_timeout: {{ default "10s" .notificationTimeout | toString }}
for_outage_tolerance: {{ default "1h" .forOutageTolerance | toString }}
for_grace_period: {{ default "10m" .forGracePeriod | toString }}
resend_delay: {{ default "1m" .resendDelay | toString }}
enable_sharding: {{ default false .enableSharding | toString }}
search_pending_for: {{ default "5m" .searchPendingFor | toString }}
{{- if .rulerClient }}
ruler_client:
  {{- if .rulerClient.tlsCertPath }}
  tls_cert_path: {{ .rulerClient.tlsCertPath | toString }}
  {{- end }}
  {{- if .rulerClient.tlsKeyPath }}
  tls_key_path: {{ .rulerClient.tlsKeyPath | toString }}
  {{- end }}
  {{- if .rulerClient.tlsCaPath }}
  tls_ca_path: {{ .rulerClient.tlsCaPath | toString }}
  {{- end }}
  tls_insecure_skip_verify: {{ default false .rulerClient.tlsInsecureSkipVerify | toString }}
{{- end }}
{{- if .storage }}
storage:
  {{- if .storage.type }}
  type: {{ .storage.type | toString }}
  {{- end }}
  {{- if and (eq .storage.type "azure") .storage.azure }}
  azure:
    environment: {{ default "AzureGlobal" .storage.azure.environment | toString }}
    container_name: {{ default "cortex" .storage.azure.containerName | toString }}
    {{- if .storage.azure.accountName }}
    account_name: {{ .storage.azure.accountName | toString }}
    {{- end }}
    {{- if .storage.azure.accountKey }}
    account_key: {{ .storage.azure.accountKey | toString }}
    {{- end }}
    download_buffer_size: {{ default 512000 .storage.azure.downloadBufferSize | int64 | toString }}
    upload_buffer_size: {{ default 256000 .storage.azure.uploadBufferSize | int64 | toString }}
    upload_buffer_count: {{ default 1 .storage.azure.uploadBufferCount | int64 | toString }}
    requestTimeout: {{ default "30s" .storage.azure.requestTimeout | toString }}
    max_retries: {{ default 5 .storage.azure.maxRetries | int64 | toString }}
    min_retry_delay: {{ default "10ms" .storage.azure.minRetryDelay | toString }}
    max_retry_delay: {{ default "500ms" .storage.azure.maxRetryDelay | toString }}
  {{- end }}
  {{- if and (eq .storage.type "gcs") .storage.gcs }}
  gcs:
    {{- if .storage.gcs.bucketName }}
    bucket_name: {{ .storage.gcs.bucketName | toString }}
    {{- end }}
    chunk_buffer_size: {{ default 0 .storage.gcs.chunkBufferSize | int64 | toString }}
    request_timeout: {{ default "0s" .storage.gcs.requestTimeout | toString }}
  {{- end }}
  {{- if and (eq .storage.type "s3") .storage.s3 }}
  s3:
    {{- if .storage.s3.s3 }}
    s3: {{ .storage.s3.s3 | toString }}
    {{- end }}
    s3forcepathstyle: {{ default false .storage.s3.s3forcepathstyle | toString }}
    {{- if .storage.s3.bucketnames }}
    bucketnames: {{ .storage.s3.bucketnames | toString }}
    {{- end }}
    {{- if .storage.s3.endpoint }}
    endpoint: {{ .storage.s3.endpoint | toString }}
    {{- end }}
    {{- if .storage.s3.region }}
    region: {{ .storage.s3.region | toString }}
    {{- end }}
    {{- if .storage.s3.accessKeyId }}
    access_key_id: {{ .storage.s3.accessKeyId | toString }}
    {{- end }}
    {{- if .storage.s3.secretAccessKey }}
    secret_access_key: {{ .storage.s3.secretAccessKey | toString }}
    {{- end }}
    insecure: {{ default false .storage.s3.insecure | toString }}
    sse_encryption: {{ default false .storage.s3.sseEncryption | toString }}
    {{- if .storage.s3.httpConfig }}
    http_config:
      idle_conn_timeout: {{ default "1m30s" .storage.s3.httpConfig.idleConnTimeout | toString }}
      response_header_timeout: {{ default "0s" .storage.s3.httpConfig.responseHeaderTimeout | toString }}
      insecure_skip_verify: {{ default false .storage.s3.httpConfig.insecureSkipVerify | toString }}
    {{- end }}
  {{- end }}
  {{- if and (eq .storage.type "swift") .storage.swift }}
  swift:
    {{- if .storage.swift.authUrl }}
    auth_url: {{ .storage.swift.authUrl | toString }}
    {{- end }}
    {{- if .storage.swift.username }}
    username: {{ .storage.swift.username | toString }}
    {{- end }}
    {{- if .storage.swift.userDomainName }}
    user_domain_name: {{ .storage.swift.userDomainName | toString }}
    {{- end }}
    {{- if .storage.swift.userDomainId }}
    user_domain_id: {{ .storage.swift.userDomainId | toString }}
    {{- end }}
    {{- if .storage.swift.userId }}
    user_id: {{ .storage.swift.userId | toString }}
    {{- end }}
    {{- if .storage.swift.password }}
    password: {{ .storage.swift.password | toString }}
    {{- end }}
    {{- if .storage.swift.domainId }}
    domain_id: {{ .storage.swift.domainId | toString }}
    {{- end }}
    {{- if .storage.swift.domainName }}
    domain_name: {{ .storage.swift.domainName | toString }}
    {{- end }}
    {{- if .storage.swift.projectId }}
    project_id: {{ .storage.swift.projectId | toString }}
    {{- end }}
    {{- if .storage.swift.projectName }}
    project_name: {{ .storage.swift.projectName | toString }}
    {{- end }}
    {{- if .storage.swift.projectDomainId }}
    project_domain_id: {{ .storage.swift.projectDomainId | toString }}
    {{- end }}
    {{- if .storage.swift.projectDomainName }}
    project_domain_name: {{ .storage.swift.projectDomainName | toString }}
    {{- end }}
    {{- if .storage.swift.regionName }}
    region_name: {{ .storage.swift.regionName | toString }}
    {{- end }}
    container_name: {{ default "cortex" .storage.swift.containerName | toString }}
  {{- end }}
  {{- if and (eq .storage.type "local") .storage.local }}
  local:
    directory: {{ default "" .storage.local.directory | toString }}
  {{- end }}
{{- end }}
{{- if .ring }}
ring:
  heartbeat_period: {{ default "5s" .ring.heartbeatPeriod | toString }}
  heartbeat_timeout: {{ default "1m" .ring.heartbeatTimeout | toString }}
  num_tokens: {{ default 128 .ring.numTokens | int64 | toString }}
  {{- if .ring.kvstore }}
  kvstore:
    store: {{ default "inmemory" .ring.kvstore.store | toString }}
    prefix: {{ default "rulers/" .ring.kvstore.prefix | toString }}
    {{- if eq .ring.kvstore.store "consul" }}
    consul:
      {{- include "loki.consulConfig" .ring.kvstore.consul | trim | nindent 6 }}
    {{- end }}
    {{- if eq .ring.kvstore.store "etcd" }}
    etcd:
      {{- include "loki.etcdConfig" .ring.kvstore.etcd | trim | nindent 6 }}
    {{- end }}
    {{- if eq .ring.kvstore.store "memberlist" }}
    memberlist:
      {{- include "loki.memberlistConfig" .ring.kvstore.memberlist | trim | nindent 6 }}
    {{- end }}
    {{- if eq .ring.kvstore.store "multi" }}
    {{-   if .ring.kvstore.multi }}
    {{-     if or (eq .ring.kvstore.multi.primary "consul") (eq .ring.kvstore.multi.secondary "consul") }}
    consul:
      {{- include "loki.consulConfig" .ring.kvstore.consul | trim | nindent 6 }}
    {{-     end }}
    {{-     if or (eq .ring.kvstore.multi.primary "etcd") (eq .ring.kvstore.multi.secondary "etcd") }}
    etcd:
      {{- include "loki.etcdConfig" .ring.kvstore.etcd | trim | nindent 6 }}
    {{-     end }}
    {{-     if or (eq .ring.kvstore.multi.primary "memberlist") (eq .ring.kvstore.multi.secondary "memberlist") }}
    memberlist:
      {{- include "loki.memberlistConfig" .ring.kvstore.memberlist | trim | nindent 6 }}
    {{-     end }}
    multi:
      primary: {{ .ring.kvstore.multi.primary | toString }}
      secondary: {{ .ring.kvstore.multi.secondary | toString }}
      mirror_enabled: {{ default false .ring.kvstore.multi.mirrorEnabled | toString }}
      mirror_timeout: {{ default "2s" .ring.kvstore.multi.mirrorTimeout | toString }}
    {{-   end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end -}}
