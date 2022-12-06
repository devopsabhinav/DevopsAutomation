{{- define "generate.pdb" -}}
{{- if .Values.pdb.enabled -}}
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  labels:
    {{- include "generate.labels" . | nindent 4 }}
  name: {{ include "generate.fullname" . }}
spec:
  {{- if .Values.pdb.minAvailable }}
  minAvailable: {{ .Values.pdb.minAvailable }}
  {{- else }}
  maxUnavailable: {{ default 1 .Values.pdb.maxUnavailable }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "generate.selectorLabels" . | nindent 6 }}
{{- end -}}
{{- end -}}
