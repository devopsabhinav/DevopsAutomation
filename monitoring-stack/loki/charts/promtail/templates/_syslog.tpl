{{- define "promtail.syslog" -}}
- job_name: syslog
  {{- with .Values.syslog.pipelineStages }}
  pipeline_stages:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  syslog:
    listen_address: {{ .Values.syslog.port | int64 | toString | printf "0.0.0.0:%s" }}
    labels:
      jobName: syslog
      {{- toYaml .Values.syslog.labels | nindent 6 }}
  relabel_configs:
    - action: labelmap
      regex: __syslog_message_(severity|facility)
    - source_labels: ['__syslog_connection_ip_address']
      target_label: connectionIpAddress
    - source_labels: ['__syslog_connection_hostname']
      target_label: connectionHostname
    - source_labels: ['__syslog_message_app_name']
      target_label: appName
{{- end -}}
