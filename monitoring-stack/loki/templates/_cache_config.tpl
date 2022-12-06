{{/* vim: set filetype=mustache: */}}
{{- define "loki.cacheConfig" -}}
{{- if not (empty .enableFifocache) }}
enable_fifocache: {{ .enableFifocache | toString }}
{{- end }}
{{- if not (empty .defaultValidity) }}
default_validity: {{ .defaultValidity | toString }}
{{- end }}
{{- if .background }}
background:
  writeback_goroutines: {{ default 10 .background.writebackGoroutines | int64 | toString }}
  writeback_buffer: {{ default 10000 .background.writebackGoroutines | int64 | toString }}
{{- end }}
{{- if .memcached }}
memcached:
  {{- if not (empty .memcached.expiration) }}
  expiration: {{ .memcached.expiration | toString }}
  {{- end }}
  {{- if not (empty .memcached.batchSize) }}
  batch_size: {{ .memcached.batchSize | int64 | toString }}
  {{- end }}
  parallelism: {{ default 100 .memcached.parallelism | int64 | toString }}
{{- end }}
{{- if .memcachedClient }}
memcached_client:
  {{- if not (empty .memcachedClient.host) }}
  host: {{ .memcachedClient.host | toString }}
  {{- end }}
  service: {{ default "memcached" .memcachedClient.service | toString }}
  timeout: {{ default "100ms" .memcachedClient.timeout | toString }}
  max_idle_conns: {{ default 100 .memcachedClient.maxIdleConns | int64 | toString }}
  update_interval: {{ default "1m" .memcachedClient.updateInterval | toString }}
  {{- if not (empty .memcachedClient.consistentHash) }}
  consistent_hash: {{ .memcachedClient.consistentHash | toString }}
  {{- end }}
{{- end }}
{{- if .redis }}
redis:
  {{- if not (empty .redis.host) }}
  host: {{ .redis.host | toString }}
  {{- end }}
  {{- if not (empty .redis.endpoint) }}
  endpoint: {{ .redis.endpoint | toString }}
  {{- end }}
  {{- if not (empty .redis.masterName) }}
  master_name: {{ .redis.masterName | toString }}
  {{- end }}
  timeout: {{ default "100ms" .redis.timeout | toString }}
  expiration: {{ default "0s" .redis.expiration | toString }}
  {{- if not (empty .redis.db) }}
  db: {{ .redis.db | int64 | toString }}
  {{- end }}
  pool_size: {{ default 0 .redis.poolSize | int64 | toString }}
  {{- if not (empty .redis.password) }}
  password: {{ .redis.password | toString }}
  {{- end }}
  idle_timeout: {{ default "0s" .redis.idleTimeout | toString }}
  max_connection_age: {{ default "0s" .redis.maxConnectionAge | toString }}
{{- end }}
{{- if .fifocache }}
fifocache:
  {{- if not (empty .fifocache.maxSizeBytes) }}
  max_size_bytes: {{ .fifocache.maxSizeBytes | toString }}
  {{- end }}
  max_size_items: {{ default 0 .fifocache.maxSizeItems | int64 | toString }}
  validity: {{ default "0s" .fifocache.validity | toString }}
{{- end }}
{{- end -}}
