{{/* vim: set filetype=mustache: */}}
{{- define "loki.querierConfig" -}}
query_timeout: {{ default "1m" .queryTimeout | toString }}
tail_max_duration: {{ default "1h" .tailMaxDuration | toString }}
extra_query_delay: {{ default "0s" .extraQueryDelay | toString }}
query_ingesters_within: {{ default "0s" .queryIngestersWithin | toString }}
{{- if .engine }}
engine:
  timeout: {{ default "3m" .engine.timeout | toString }}
  max_look_back_period: {{ default "30s" .engine.maxLookBackPeriod | toString }}
{{- end }}
{{- end -}}
