{{/* vim: set filetype=mustache: */}}
{{- define "loki.chunkStoreConfig" -}}
{{- if .chunkCacheConfig }}
chunk_cache_config:
  {{- include "loki.cacheConfig" .chunkCacheConfig | trim | nindent 2 }}
{{- end }}
{{- if .writeDedupeCacheConfig }}
write_dedupe_cache_config:
  {{- include "loki.cacheConfig" .writeDedupeCacheConfig | trim | nindent 2 }}
{{- end }}
{{- if .cacheLookupsOlderThan }}
cache_lookups_older_than: {{ .cacheLookupsOlderThan | toString }}
{{- end }}
{{- if .maxLookBackPeriod }}
max_look_back_period: {{ .maxLookBackPeriod | toString }}
{{- end }}
{{- end -}}
