{{/* vim: set filetype=mustache: */}}
{{- define "loki.limitsConfig" -}}
ingestion_rate_strategy: {{ default "local" .ingestionRateStrategy | toString }}
ingestion_rate_mb: {{ default 4 .ingestionRateMb | float64 | toString }}
ingestion_burst_size_mb: {{ default 6 .ingestionBurstSizeMb | int64 | toString }}
max_label_name_length: {{ default 1024 .maxLabelNameLength | int64 | toString }}
max_label_value_length: {{ default 2048 .maxLabelValueLength | int64 | toString }}
max_label_names_per_series: {{ default 30 .maxLabelNamesPerSeries | int64 | toString }}
reject_old_samples: {{ default false .rejectOldSamples | toString }}
reject_old_samples_max_age: {{ default "336h" .rejectOldSamplesMaxAge | toString }}
creation_grace_period: {{ default "10m" .creationGracePeriod | toString }}
enforce_metric_name: {{ default false .enforceMetricName | toString }}
max_streams_per_user: {{ default 10000 .maxStreamsPerUser | int64 | toString }}
{{- if .maxLineSize }}
max_line_size: {{ .maxLineSize | toString }}
{{- end }}
max_entries_limit_per_query: {{ default 5000 .maxEntriesLimitPerQuery | int64 | toString }}
max_global_streams_per_user: {{ default 0 .maxGlobalStreamsPerUser | int64 | toString }}
max_chunks_per_query: {{ default 2000000 .maxChunksPerQuery | int64 | toString }}
max_query_length: {{ default "0s" .maxQueryLength | toString }}
max_query_parallelism: {{ default 14 .maxQueryParallelism | int64 | toString }}
cardinality_limit: {{ default 100000 .cardinalityLimit | int64 | toString }}
max_streams_matchers_per_query: {{ default 1000 .maxStreamsMatchersPerQuery | int64 | toString }}
{{- if .perTenantOverrideConfig }}
per_tenant_override_config: {{ .perTenantOverrideConfig | toString }}
{{- end }}
per_tenant_override_period: {{ default "10s" .perTenantOverridePeriod | toString }}
{{- end -}}
