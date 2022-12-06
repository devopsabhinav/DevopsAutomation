{{/* vim: set filetype=mustache: */}}
{{- define "loki.etcdConfig" -}}
{{- with .endpoints }}
endpoints:
  {{- toYaml . | nindent 2 }}
{{- end }}
dial_timeout: {{ default "10s" .dialTimeout | toString }}
max_retries: {{ default 10 .maxRetries | int64 | toString }}
{{- end -}}
