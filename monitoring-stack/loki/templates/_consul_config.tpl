{{/* vim: set filetype=mustache: */}}
{{- define "loki.consulConfig" -}}
host: {{ default "localhost:8500" .host | toString }}
{{- if .aclToken }}
acl_token: {{ .aclToken | toString }}
{{- end }}
http_client_timeout: {{ default "20s" .httpClientTimeout | toString }}
{{- if not (empty .consistentReads) }}
consistent_reads: {{ .consistentReads | toString }}
{{- end }}
{{- end -}}
