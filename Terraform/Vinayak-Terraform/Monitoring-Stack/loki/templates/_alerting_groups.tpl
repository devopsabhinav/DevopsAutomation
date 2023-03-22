{{/* vim: set filetype=mustache: */}}
{{- define "loki.alertingGroups" -}}
groups:
  {{- range $g, $group := .Values.alertingGroups }}
  - name: {{ $group.name }}
    rules:
    {{- range $r, $rule := $group.rules }}
      - alert: {{ $rule.alert }}
        expr: {{ $rule.expr | quote }}
        for: {{ $rule.for | default "10m" }}
        {{- with $rule.annotations }}
        labels:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        {{- with $rule.annotations }}
        annotations:
          {{- toYaml . | nindent 10 }}
        {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}
