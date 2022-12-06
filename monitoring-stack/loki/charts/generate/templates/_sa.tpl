{{- define "generate.sa" -}}
{{- if .Values.serviceAccount.create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "generate.labels" . | nindent 4 }}
    {{- with .Values.serviceAccount.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  name: {{ include "generate.serviceAccountName" . }}
{{- end -}}
{{- end -}}
