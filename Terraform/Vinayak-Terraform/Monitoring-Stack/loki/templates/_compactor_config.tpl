{{/* vim: set filetype=mustache: */}}
{{- define "loki.compactorConfig" -}}
{{- if .workingDirectory }}
working_directory: {{ .workingDirectory | toString }}
{{- end }}
{{- if .sharedStore }}
shared_store: {{ .sharedStore | toString }}
{{- end }}
{{- if .compactionInterval }}
compaction_interval: {{ .compactionInterval | toString }}
{{- end }}
{{- end -}}
