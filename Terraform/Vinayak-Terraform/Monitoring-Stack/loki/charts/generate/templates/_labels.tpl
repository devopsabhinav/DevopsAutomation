{{/*
Expand the name of the chart.
*/}}
{{/*
Common labels
*/}}
{{- define "generate.labels" -}}
{{ include "generate.minimalLabels" . }}
{{ include "generate.selectorLabels" . }}
{{- if .Values.enabled }}
app.kubernetes.io/part-of: {{ .Release.Name }}
{{- end }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Minimal labels
*/}}
{{- define "generate.minimalLabels" -}}
helm.sh/chart: {{ include "generate.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "generate.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generate.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.enabled }}
app.kubernetes.io/component: {{ .Chart.Name }}
{{- end }}
{{- end }}
