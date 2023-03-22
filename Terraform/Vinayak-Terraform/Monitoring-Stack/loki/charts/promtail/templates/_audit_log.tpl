{{- define "promtail.auditLogPath" -}}
{{- default "/var/log/audit/audit.log" .Values.auditLog.path -}}
{{- end -}}

{{- define "promtail.auditLogDirectory" -}}
{{- include "promtail.auditLogPath" . | dir -}}
{{- end -}}

{{- define "promtail.scrapeAuditLog" -}}
- job_name: auditLog
  {{- with .Values.auditLog.pipelineStages }}
  pipeline_stages:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  static_configs:
    - labels:
        __path__: {{ include "promtail.auditLogPath" . }}
        jobName: auditLog
  relabel_configs: []
{{- end -}}
