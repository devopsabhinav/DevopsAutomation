{{- define "promtail.podsDirectory" -}}
{{- default "/var/log/pods" .Values.pods.directory -}}
{{- end -}}

{{- define "promtail.podsFilterNamespaces" -}}
{{- if .Values.pods.excludeNamespaces }}
- action: drop
  regex: {{ join "|" .Values.pods.excludeNamespaces | printf "^(%s)$" }}
  source_labels:
    - __meta_kubernetes_namespace
{{- end -}}
{{- end -}}

{{- define "promtail.podsRelabeling" -}}
- target_label: __host__
  source_labels:
    - __meta_kubernetes_pod_node_name
- target_label: job
  separator: /
  source_labels:
    - __meta_kubernetes_namespace
    - __service__
  replacement: $1
- target_label: namespace
  source_labels:
    - __meta_kubernetes_namespace
- target_label: pod
  source_labels:
    - __meta_kubernetes_pod_name
- target_label: container
  source_labels:
    - __meta_kubernetes_pod_container_name
- action: labelmap
  regex: __meta_kubernetes_pod_label_(.+)
{{- if .Values.pods.dropLabels }}
- action: labeldrop
  regex: {{ join "|" .Values.pods.dropLabels | lower | replace "." "_" | replace "-" "_" | replace "/" "_" | printf "^(%s)$" | squote }}
{{- end }}
- action: labelmap
  regex: {{ .Values.pods.annotationPrefix | lower | replace "." "_" | replace "-" "_" | replace "/" "_" | printf "__meta_kubernetes_pod_annotation_%s_(.+)" }}
  replacement: $1
{{- end -}}

{{- define "promtail.podsPipelineStages" -}}
{{- if .Values.pods.pipelineStages }}
{{    toYaml .Values.pods.pipelineStages }}
{{- else }}
{{- if eq .Values.pods.cri "docker" }}
- docker: {}
{{- end -}}
{{- if eq .Values.pods.cri "cri-o" }}
- cri: {}
{{- end -}}
{{- if eq .Values.pods.cri "auto" }}
- LOGFORMAT: {}
{{- end -}}
{{- if eq .Values.pods.parseLevels true }}
{{    include "promtail.podsLogLevelParser" . }}
{{- end }}
{{- if eq .Values.pods.dropDebug true }}
{{    include "promtail.podsDropDebug" . }}
{{- end }}
{{- if eq .Values.pods.dropReadinessProbes true }}
{{    include "promtail.podsDropReadinessProbes" . }}
{{- end }}
{{- if eq .Values.pods.dropDeprecated true }}
{{    include "promtail.podsDropDeprecated" . }}
{{- end }}
{{- if eq .Values.pods.parseNginxAccessLog true }}
{{    include "promtail.podsNginxAccessLogParser" . }}
{{- end }}
{{- if eq .Values.pods.parseGolang true }}
{{    include "promtail.podsGolangParser" . }}
{{- end }}
{{- if eq .Values.pods.parseJava true }}
{{    include "promtail.podsJavaParser" . }}
{{- end }}
{{- if eq .Values.pods.parseKnownApps true }}
{{    include "promtail.podsEtcdParser" . }}
{{    include "promtail.podsKubernetesDasboardParser" . }}
{{    include "promtail.podsDasboardMetricsScraperParser" . }}
{{    include "promtail.podsGrafanaParser" . }}
{{    include "promtail.podsGrafanaOperatorParser" . }}
{{    include "promtail.podsRocketMQParser" . }}
{{    include "promtail.podsGitlabRunnerParser" . }}
{{    include "promtail.podsVaultParser" . }}
{{    include "promtail.podsConsulParser" . }}
{{    include "promtail.podsCalicoParser" . }}
{{    include "promtail.podsMongoParser" . }}
{{    include "promtail.podsStolonKeeperParser" . }}
{{    include "promtail.podsPgBouncerParser" . }}
{{    include "promtail.podsVeleroParser" . }}
{{    include "promtail.podsGitLabServerParser" . }}
{{- end }}
{{- end }}
{{- if .Values.pods.extraPipelineStages }}
{{    toYaml .Values.pods.extraPipelineStages }}
{{- end }}
{{- end -}}

{{- define "promtail.scrapePods" -}}
- job_name: podsName
  pipeline_stages:
    {{- include "promtail.podsPipelineStages" . | trim | nindent 4 }}
  kubernetes_sd_configs:
    - role: pod
  relabel_configs:
    {{- include "promtail.podsFilterNamespaces" . | trim | nindent 4 }}
    - target_label: __service__
      source_labels:
        - __meta_kubernetes_pod_label_name
    - action: drop
      regex: ''
      source_labels:
        - __service__
    {{- include "promtail.podsRelabeling" . | trim | nindent 4 }}
    - target_label: __path__
      separator: /
      source_labels:
        - __meta_kubernetes_pod_uid
        - __meta_kubernetes_pod_container_name
      replacement: {{ include "promtail.podsDirectory" . | printf "%s/*$1/*.log" }}

- job_name: podsApp
  pipeline_stages:
    {{- include "promtail.podsPipelineStages" . | trim | nindent 4 }}
  kubernetes_sd_configs:
    - role: pod
  relabel_configs:
    {{- include "promtail.podsFilterNamespaces" . | trim | nindent 4 }}
    - action: drop
      regex: .+
      source_labels:
        - __meta_kubernetes_pod_label_name
    - source_labels:
        - __meta_kubernetes_pod_label_app
      target_label: __service__
    - action: drop
      regex: ''
      source_labels:
        - __service__
    {{- include "promtail.podsRelabeling" . | trim | nindent 4 }}
    - target_label: __path__
      separator: /
      source_labels:
        - __meta_kubernetes_pod_uid
        - __meta_kubernetes_pod_container_name
      replacement: {{ include "promtail.podsDirectory" . | printf "%s/*$1/*.log" }}

- job_name: podsDirectControllers
  pipeline_stages:
    {{- include "promtail.podsPipelineStages" . | trim | nindent 4 }}
  kubernetes_sd_configs:
    - role: pod
  relabel_configs:
    {{- include "promtail.podsFilterNamespaces" . | trim | nindent 4 }}
    - action: drop
      regex: .+
      separator: ''
      source_labels:
        - __meta_kubernetes_pod_label_name
        - __meta_kubernetes_pod_label_app
    - action: drop
      regex: '[0-9a-z-.]+-[0-9a-f]{8,10}'
      source_labels:
        - __meta_kubernetes_pod_controller_name
    - source_labels:
        - __meta_kubernetes_pod_controller_name
      target_label: __service__
    - action: drop
      regex: ''
      source_labels:
        - __service__
    {{- include "promtail.podsRelabeling" . | trim | nindent 4 }}
    - target_label: __path__
      separator: /
      source_labels:
        - __meta_kubernetes_pod_uid
        - __meta_kubernetes_pod_container_name
      replacement: {{ include "promtail.podsDirectory" . | printf "%s/*$1/*.log" }}

- job_name: podsIndirectControllers
  pipeline_stages:
    {{- include "promtail.podsPipelineStages" . | trim | nindent 4 }}
  kubernetes_sd_configs:
    - role: pod
  relabel_configs:
    {{- include "promtail.podsFilterNamespaces" . | trim | nindent 4 }}
    - action: drop
      regex: .+
      separator: ''
      source_labels:
        - __meta_kubernetes_pod_label_name
        - __meta_kubernetes_pod_label_app
    - action: keep
      regex: '[0-9a-z-.]+-[0-9a-f]{8,10}'
      source_labels:
        - __meta_kubernetes_pod_controller_name
    - action: replace
      regex: '([0-9a-z-.]+)-[0-9a-f]{8,10}'
      source_labels:
        - __meta_kubernetes_pod_controller_name
      target_label: __service__
    - action: drop
      regex: ''
      source_labels:
        - __service__
    {{- include "promtail.podsRelabeling" . | trim | nindent 4 }}
    - target_label: __path__
      separator: /
      source_labels:
        - __meta_kubernetes_pod_uid
        - __meta_kubernetes_pod_container_name
      replacement: {{ include "promtail.podsDirectory" . | printf "%s/*$1/*.log" }}

- job_name: podsStatic
  pipeline_stages:
    {{- include "promtail.podsPipelineStages" . | trim | nindent 4 }}
  kubernetes_sd_configs:
    - role: pod
  relabel_configs:
    {{- include "promtail.podsFilterNamespaces" . | trim | nindent 4 }}
    - action: drop
      regex: ''
      source_labels:
        - __meta_kubernetes_pod_annotation_kubernetes_io_config_mirror
    - action: replace
      source_labels:
        - __meta_kubernetes_pod_label_component
      target_label: __service__
    - action: drop
      regex: ''
      source_labels:
        - __service__
    {{- include "promtail.podsRelabeling" . | trim | nindent 4 }}
    - target_label: __path__
      separator: /
      source_labels:
        - __meta_kubernetes_pod_annotation_kubernetes_io_config_mirror
        - __meta_kubernetes_pod_container_name
      replacement: {{ include "promtail.podsDirectory" . | printf "%s/*$1/*.log" }}
{{- end -}}
