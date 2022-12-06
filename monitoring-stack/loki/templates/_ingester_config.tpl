{{/* vim: set filetype=mustache: */}}
{{- define "loki.ingesterConfig" -}}
{{- if .lifecycler }}
lifecycler:
  num_tokens: {{ default 128 .lifecycler.numTokens | int64 | toString }}
  heartbeat_period: {{ default "5s" .lifecycler.heartbeatPeriod | toString }}
  join_after: {{ default "0s" .lifecycler.joinAfter | toString }}
  min_ready_duration: {{ default "1m" .lifecycler.minReadyDuration | toString }}
  {{- if .lifecycler.interfaceNames }}
  {{- with .lifecycler.interfaceNames }}
  interface_names:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- end }}
  final_sleep: {{ default "30s" .lifecycler.finalSleep | toString }}
  {{- if .lifecycler.ring }}
  ring:
    heartbeat_timeout: {{ default "1m" .lifecycler.ring.heartbeatTimeout | toString }}
    replication_factor: {{ default 3 .lifecycler.ring.replicationFactor | int64 | toString }}
    {{- if .lifecycler.ring.kvstore }}
    kvstore:
      store: {{ default "inmemory" .lifecycler.ring.kvstore.store | toString }}
      {{- if eq .lifecycler.ring.kvstore.store "consul" }}
      consul:
        {{- include "loki.consulConfig" .lifecycler.ring.kvstore.store.consul | trim | nindent 8 }}
      {{- end }}
      {{- if eq .lifecycler.ring.kvstore.store "etcd" }}
      etcd:
        {{- include "loki.etcdConfig" .lifecycler.ring.kvstore.store.etcd | trim | nindent 8 }}
      {{- end }}
      {{- if eq .lifecycler.ring.kvstore.store "memberlist" }}
      memberlist:
        {{- include "loki.memberlistConfig" .lifecycler.ring.kvstore.store.memberlist | trim | nindent 8 }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
max_transfer_retries: {{ default 10 .maxTransferRetries | int64 | toString }}
concurrent_flushes: {{ default 16 .concurrentFlushes | int64 | toString }}
flush_check_period: {{ default "30s" .flushCheckPeriod | toString }}
flush_op_timeout: {{ default "10s" .flushOpTimeout | toString }}
chunk_retain_period: {{ default "15m" .chunkRetainPeriod | toString }}
chunk_idle_period: {{ default "30m" .chunkIdlePeriod | toString }}
chunk_block_size: {{ default 262144 .chunkBlockSize | int64 | toString }}
chunk_target_size: {{ default 0 .chunkTargetSize | int64 | toString }}
chunk_encoding: {{ default "gzip" .chunkEncoding | toString }}
sync_period: {{ default "0s" .syncPeriod | toString }}
sync_min_utilization: {{ default 0 .syncMinUtilization | int64 | toString }}
max_returned_stream_errors: {{ default 10 .maxReturnedStreamErrors | int64 | toString }}
max_chunk_age: {{ default "1h" .maxChunkAge | toString }}
query_store_max_look_back_period: {{ default "0s" .queryStoreMaxLookBackPeriod | toString }}
{{- end -}}
