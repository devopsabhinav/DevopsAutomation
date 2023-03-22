{{- define "promtail.systemJournalDirectory" -}}
{{- default "/var/log/journal" .Values.systemJournal.directory -}}
{{- end -}}

{{- define "promtail.scrapeSystemJournal" -}}
- job_name: systemJournal
  {{- with .Values.systemJournal.pipelineStages }}
  pipeline_stages:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  journal:
    json: {{ .Values.systemJournal.json | toString }}
    max_age: {{ .Values.systemJournal.maxAge | toString }}
    path: {{ include "promtail.systemJournalDirectory" . }}
    labels:
      jobName: systemJournal
  relabel_configs:
    - source_labels: ['__journal__systemd_unit']
      target_label: systemdUnit
{{- end -}}
