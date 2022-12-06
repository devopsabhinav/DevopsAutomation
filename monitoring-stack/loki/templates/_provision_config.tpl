{{/* vim: set filetype=mustache: */}}
{{- define "loki.provisionConfig" -}}
enable_ondemand_throughput_mode: {{ default false .enableOndemandThroughputMode | toString }}
provisioned_write_throughput: {{ default 3000 .provisionedWriteThroughput | int64 | toString }}
provisioned_read_throughput: {{ default 300 .provisionedReadThroughput | int64 | toString }}
enable_inactive_throughput_on_demand_mode: {{ default false .enableInactiveThroughputOnDemandMode | toString }}
inactive_write_throughput: {{ default 1 .inactiveWriteThroughput | int64 | toString }}
inactive_read_throughput: {{ default 300 .inactiveReadThroughput | int64 | toString }}
{{- if .writeScale }}
write_scale:
  {{- include "loki.autoScalingConfig" .writeScale | trim | nindent 2 }}
{{- end }}
{{- if .inactiveWriteScale }}
inactive_write_scale:
  {{- include "loki.autoScalingConfig" .inactiveWriteScale | trim | nindent 2 }}
{{- end }}
{{- if .inactiveWriteScaleLastn }}
inactive_write_scale_lastn: {{ .inactiveWriteScaleLastn | int64 | toString }}
{{- end }}
{{- if .readScale }}
read_scale:
  {{- include "loki.autoScalingConfig" .readScale | trim | nindent 2 }}
{{- end }}
{{- if .inactiveReadScale }}
inactive_read_scale:
  {{- include "loki.autoScalingConfig" .inactiveReadScale | trim | nindent 2 }}
{{- end }}
{{- if .inactiveReadScaleLastn }}
inactive_read_scale_lastn: {{ .inactiveReadScaleLastn | int64 | toString }}
{{- end }}
{{- end -}}
