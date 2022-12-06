{{/* vim: set filetype=mustache: */}}
{{- define "loki.frontendConfig" -}}
max_outstanding_per_tenant: {{ default 100 .maxOutstandingPerTenant | int64 | toString }}
compress_responses: {{ default false .compressResponses | toString }}
{{- if .downstreamUrl }}
downstream_url: {{ .downstreamUrl | toString }}
{{- end }}
log_queries_longer_than: {{ default "0s" .logQueriesLongerThan | toString }}
{{- end -}}
