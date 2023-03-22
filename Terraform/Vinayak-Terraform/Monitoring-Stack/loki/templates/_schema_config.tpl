{{/* vim: set filetype=mustache: */}}
{{- define "loki.schemaConfig" -}}
configs:
  {{- range $i, $config := .configs }}
  - from: {{ $config.from | toString }}
    store: {{ $config.store | toString }}
    object_store: {{ $config.objectStore | toString }}
    schema: {{ $config.schema | toString }}
    {{- if $config.rowShards }}
    row_shards: {{ $config.rowShards | int64 | toString }}
    {{- end }}
    {{- if $config.index }}
    index:
      prefix: {{ $config.index.prefix | toString }}
      period: {{ default "168h" $config.index.period | toString }}
      {{- with $config.index.tags }}
      tags:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- end }}
    {{- if $config.chunks }}
    chunks:
      prefix: {{ $config.chunks.prefix | toString }}
      period: {{ default "168h" $config.chunks.period | toString }}
      {{- with $config.chunks.tags }}
      tags:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}
