{{/* vim: set filetype=mustache: */}}
{{- define "loki.queryRangeConfig" -}}
split_queries_by_interval: {{ default "0s" .splitQueriesByInterval | toString }}
align_queries_with_step: {{ default false .alignQueriesWithStep | toString }}
cache_results: {{ default false .cacheResults | toString }}
max_retries: {{ default 5 .maxRetries | int64 | toString }}
parallelise_shardable_queries: {{ default false .paralleliseShardableQueries | toString }}
{{- if eq .cacheResults true }}
results_cache:
  cache:
    {{- include "loki.cacheConfig" .resultsCache.cache | trim | nindent 4 }}
{{- end }}
{{- end -}}
