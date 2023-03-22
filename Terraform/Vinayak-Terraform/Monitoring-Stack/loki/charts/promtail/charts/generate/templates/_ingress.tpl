{{- define "generate.ingressApiVersion" -}}
{{- if or (.Capabilities.APIVersions.Has "networking.k8s.io/v1/Ingress") (semverCompare ">=1.19" .Capabilities.KubeVersion.GitVersion) -}}
{{- print "networking.k8s.io/v1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- end -}}
{{- end -}}

{{- define "generate.ingress" -}}
{{- $apiVersion := include "generate.ingressApiVersion" . -}}
{{- $name := include "generate.fullname" . -}}
{{- $commonLabels := include "generate.labels" . -}}
{{- $servicePort := .Values.service.httpPort | toString -}}
{{- if .Values.ingress.enabled -}}
{{- with .Values.ingress }}
apiVersion: {{ $apiVersion }}
kind: Ingress
metadata:
  {{- with .annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- $commonLabels | nindent 4 }}
    {{- with .labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  name: {{ $name }}
spec:
  {{- if .className }}
  ingressClassName: {{ .className }}
  {{- end }}
  {{- if .tls }}
  tls:
    {{- range .tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      {{- if .secretName }}
      secretName: {{ .secretName }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- if .hosts }}
  rules:
    {{- range .hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ . }}
            pathType: Prefix
            backend:
              {{- if eq $apiVersion "networking.k8s.io/v1beta1" }}
              serviceName: {{ $name }}
              servicePort: {{ $servicePort }}
              {{- else }}
              service:
                name: {{ $name }}
                port:
                  number: {{ $servicePort }}
              {{- end }}
          {{- end }}
    {{- end }}
  {{- else }}
  backend:
    {{- if eq $apiVersion "networking.k8s.io/v1beta1" }}
    serviceName: {{ $name }}
    servicePort: {{ $servicePort }}
    {{- else }}
    service:
      name: {{ $name }}
      port:
        number: {{ $servicePort }}
    {{- end }}
  {{- end }}
{{- end -}}
{{- end -}}
{{- end -}}
