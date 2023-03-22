{{/* vim: set filetype=mustache: */}}
{{- define "loki.autoScalingConfig" -}}
enabled: {{ default false .enabled | toString }}
{{- if .roleArn }}
role_arn: {{ .roleArn | toString }}
{{- end }}
min_capacity: {{ default 3000 .minCapacity | int64 | toString }}
max_capacity: {{ default 6000 .maxCapacity | int64 | toString }}
out_cooldown: {{ default 1800 .outCooldown | int64 | toString }}
in_cooldown: {{ default 1800 .inCooldown | int64 | toString }}
target: {{ default 80 .target | float64 | toString }}
{{- end -}}
