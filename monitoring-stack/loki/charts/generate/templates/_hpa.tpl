{{- define "generate.hpa" -}}
{{- if .Values.autoscaling.enabled }}
{{- $kind := default "Deployment" .Values.deploymentType -}}
{{- if and (ne $kind "Deployment") (ne $kind "StatefulSet") -}}
{{- fail "Invalid deployment type for autoscaling" -}}
{{- end -}}
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  labels:
    {{- include "generate.labels" . | nindent 4 }}
  name: {{ include "generate.fullname" . }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: {{ $kind }}
    name: {{ include "generate.fullname" . }}
  minReplicas: {{ .Values.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas }}
  targetCPUUtilizationPercentage: {{ .Values.autoscaling.targetCPUUtilizationPercentage }}
{{- end }}
{{- end -}}
