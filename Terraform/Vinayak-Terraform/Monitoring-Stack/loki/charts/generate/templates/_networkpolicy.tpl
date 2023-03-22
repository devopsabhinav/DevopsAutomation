{{- define "generate.networkPolicy" -}}
{{- if .Values.networkPolicy.enabled -}}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  {{- with .Values.networkPolicy.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "generate.labels" . | nindent 4 }}
    {{- with .Values.networkPolicy.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  name: {{ include "generate.fullname" . }}
spec:
  podSelector:
    matchLabels:
      {{- include "generate.selectorLabels" . | nindent 6 }}
  policyTypes:
  {{- if .Values.networkPolicy.ingress }}
    - Ingress
  {{- end }}
  {{- if .Values.networkPolicy.egress }}
    - Egress
  {{- end }}
  {{- with .Values.networkPolicy.ingress }}
  ingress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.networkPolicy.egress }}
  egress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
{{- end -}}
