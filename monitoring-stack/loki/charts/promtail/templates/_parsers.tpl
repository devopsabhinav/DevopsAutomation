{{- define "promtail.podsLogLevelParser" -}}
- match:
    selector: '{pod=~".+"} |~ `^level=\w+\s`'
    stages:
      - regex:
          expression: '^level=(?P<level>\w+)\s+(?P<output>.*)$'
      - template:
          source: parser
          template: loglevel
      - template:
          source: level
          template: {{ "'{{ ToLower .Value }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - template:
          source: output
          template: {{ "'{{ TrimSpace .Value }}'" }}
      - labels:
          level:
      - output:
          source: output
- match:
    selector: '{pod=~".+"} |~ `^(DEBUG|NOTICE|INFO|WARNING|WARN|ERROR)\b`'
    stages:
      - regex:
          expression: '^(?s)(?P<level>\w+)(?P<output>.*)$'
      - template:
          source: parser
          template: loglevel
      - template:
          source: level
          template: {{ "'{{ ToLower .Value }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - template:
          source: output
          template: {{ "'{{ TrimSpace .Value }}'" }}
      - labels:
          level:
      - output:
          source: output
{{- end -}}

{{- define "promtail.podsGolangParser" -}}
- match:
    selector: '{pod=~".+"} |~ `^[DNIWEF]\d+ .*.go:\d+\] `'
    stages:
      - regex:
          expression: '^(?s)(?P<level>[DNIWEF])\d+.*\s(?P<file>[a-zA-Z0-9_/-]+\.go):(?P<line>\d+)\]\s+(?P<message>.*)$'
      - template:
          source: parser
          template: golang
      - template:
          source: level
          template: {{ "'{{ if eq .level \"D\" }}debug{{ else if eq .level \"N\" }}notice{{ else if eq .level \"I\" }}info{{ else if eq .level \"W\" }}warning{{ else if eq .level \"E\" }}error{{ else if eq .level \"F\" }}fatal{{ end }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          level:
          file:
          line:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsJavaParser" -}}
- match:
    selector: '{pod=~".+"} |~ `\d{4} (FINEST|FINER|FINE|CONFIG|INFO|WARNING|WARN|SEVERE) .*\[[\w-]+\]\s+[*]\w+ `'
    stages:
      - regex:
          expression: '.*\d{4}\s+(?P<level>[A-Z]+)\s+\[(?P<logger>[\w-]+)\]\s+(?P<message>.*)?'
      - template:
          source: parser
          template: java
      - template:
          source: level
          template: {{ "'{{ ToLower .Value }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: ^fine
          drop_counter_reason: drop_debug
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          level:
          logger:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsEtcdParser" -}}
- match:
    selector: '{container="etcd"} |~ `\d [DNIWEF] \| \w+`'
    stages:
      - regex:
          expression: '.* (?P<level>[DNIWEF]) \| (?P<package>[\w/]+): (?P<message>.*)?'
      - template:
          source: parser
          template: etcd
      - template:
          source: level
          template: {{ "'{{ if eq .Value \"D\" }}debug{{ else if eq .Value \"N\" }}notice{{ else if eq .Value \"I\" }}info{{ else if eq .Value \"W\" }}warning{{ else if eq .Value \"E\" }}error{{ else if eq .Value \"F\" }}fatal{{ end }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      {{- if .Values.pods.dropReadinessProbes }}
      - drop:
          source: message
          expression: health\sOK\s
          drop_counter_reason: drop_readiness_probes
      {{- end }}
      - labels:
          level:
          package:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsNginxAccessLogParser" -}}
- match:
    selector: '{pod=~".+"} |~ ` [+-][0-9]{4}\] "[A-Z]+ `'
    stages:
      - regex:
          expression: '^(?P<ip>\S+) (?P<identd>\S+) (?P<user>\S+) \[(?P<timestamp>[\w:/]+\s[+\-]\d{4})\] "(?P<method>\S+) (?P<path>\S+) (?P<protocol>\S+)" (?P<status>\d{3}|-) (?P<size>\d+|-) "(?P<referer>[^"]*)" "(?P<useragent>[^"]*)"?'
      {{- if .Values.pods.dropReadinessProbes }}
      - drop:
          source: useragent
          expression: '^kube-probe/[0-9]+'
          drop_counter_reason: drop_readiness_probes
      - drop:
          source: path
          expression: '^(/healthz|ready|ping)$'
          drop_counter_reason: drop_readiness_probes
      {{- end }}
      - template:
          source: parser
          template: nginx-access-log
      - labels:
          parser:
          method:
          protocol:
          status:
      - timestamp:
          source: timestamp
          format: RFC822Z
      - template:
          source: output
          template: {{ .Values.pods.nginxOutputTemplate | squote }}
      - output:
          source: output
{{- end -}}

{{- define "promtail.podsKubernetesDasboardParser" -}}
- match:
    selector: '{container="kubernetes-dashboard"} |~ `^[\d/]+ `'
    stages:
      - template:
          source: parser
          template: kubernetes-dashboard
      - labels:
          parser:
      - replace:
          expression: '^([\d/]+ [\d:]+\s)'
          replace: ''
      {{- if .Values.pods.dropReadinessProbes }}
      - drop:
          expression: ' 127.0.0.1 with 200 '
          drop_counter_reason: drop_readiness_probes
      {{- end }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          expression: '^(Getting|Skipping|Found)\s\w+'
          drop_counter_reason: drop_debug
      {{- end }}
      - replace:
          expression: '^(\[.*\]\s)'
          replace: ''
{{- end -}}

{{- define "promtail.podsDasboardMetricsScraperParser" -}}
- match:
    selector: '{container="dashboard-metrics-scraper"} |~ `"level":"`'
    stages:
      - json:
          expressions:
            level:
            output: msg
            timestamp: time
      - template:
          source: parser
          template: dashboard-metrics-scraper-level
      - labels:
          level:
          parser:
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - timestamp:
          source: time
          format: RFC3339Nano
      - output:
          source: output
{{- end -}}

{{- define "promtail.podsGrafanaParser" -}}
- match:
    selector: '{container="grafana"} |~ `^t=\d+`'
    stages:
      - regex:
          expression: ' lvl=(?P<level>\w+) .* logger=(?P<logger>[^\s]+)'
      - template:
          source: parser
          template: grafana
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      - drop:
          expression: status=302
          drop_counter_reason: drop_debug
      - drop:
          expression: remote_addr=127.0.0.1
          drop_counter_reason: drop_debug
      {{- end }}
      - replace:
          expression: '(t=.*msg=).*(logger=[^\s]+)'
          replace: ''
      - labels:
          level:
          logger:
          parser:
{{- end -}}

{{- define "promtail.podsGrafanaOperatorParser" -}}
- match:
    selector: '{name="grafana-operator"}'
    stages:
      - json:
          expressions:
            level:
            logger:
            message: msg
      - labels:
          level:
          logger:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsRocketMQParser" -}}
- match:
    selector: '{app_kubernetes_io_name="rocketmq"}'
    stages:
      - regex:
          expression: '^(?s).* (?P<level>[A-Z]+) (?P<thread>\S+) - (?P<message>.*)$'
      - template:
          source: level
          template: {{ "'{{ ToLower .Value }}'" }}
      - labels:
          level:
          thread:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsGitlabRunnerParser" -}}
- match:
    selector: '{container="gitlab-runner"} |~ `^{"\w+":`'
    stages:
      - json:
          expressions:
            duration:
            job:
            level:
            message: msg
            project:
            runner:
      - template:
          source: parser
          template: gitlab-runner
      - template:
          source: level
          template: {{ "'{{ ToLower .Value }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          duration:
          job:
          level:
          project:
          runner:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsVaultParser" -}}
- match:
    selector: '{app="vault"} |~ `^time="\d+`'
    stages:
      - regex:
          expression: '.* level=(?P<level>\w+) msg="(?P<message>[^"]+)"'
      - template:
          source: parser
          template: vault
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          level:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsConsulParser" -}}
- match:
    selector: '{container="consul"} |~ ` \[[A-Z]+\] `'
    stages:
      - regex:
          expression: '.* \[(?P<level>\w+)\]\s+(?P<message>.*)?'
      - template:
          source: parser
          template: consul
      - template:
          source: level
          template: {{ "'{{ ToLower .Value }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          level:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsCalicoParser" -}}
- match:
    selector: '{container="calico-node"} |~ ` \[[A-Z]+\]\[\d+\] `'
    stages:
      - regex:
          expression: '^(?s)[\d-]+\s+[\d:\.]+\s+\[(?P<level>\w+)\]\[\d+\]\s+(?P<file>[a-zA-Z0-9_/-]+\.go)\s+(?P<line>\d+):\s+(?P<message>.*)$'
      - template:
          source: parser
          template: calico
      - template:
          source: level
          template: {{ "'{{ ToLower .Value }}'" }}
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          level:
          file:
          line:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsMongoParser" -}}
- match:
    selector: '{app="mongo"}'
    stages:
      - regex:
          expression: '^(?P<timestamp>[^ ]*)\s+(?P<level>\w)\s+(?P<component>[^ ]*)\s+\[(?P<thread>.*)\]\s+(?P<message>.*)'
      - template:
          source: parser
          template: mongo
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          level:
          component:
          thread:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsStolonKeeperParser" -}}
- match:
    selector: '{app="stolon",component="stolon-keeper"} !~ "^.*cmd/.*\\.go.*"'
    stages:
      - regex:
          expression: '^(?P<timestamp>\S+\s+\S+\s+\S+)\s+(?P<username>\S+)?\s+?-\s+?(?P<database>\S+)?:\s+(?P<level>\b[A-Z0-9]{3,}\b)?:?\s+?(?P<message>.*)'
      - template:
          source: parser
          template: stolon-keeper
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          username:
          database:
          level:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsPgBouncerParser" -}}
- match:
    selector: '{container="pgbouncer"}'
    stages:
      - regex:
          expression: '^(?P<timestamp>\S+\s+\S+\s+\S+)\s+\[(?P<pid>.*)\]\s+(?P<level>\b[A-Z0-9]{3,}\b)?\s+?(?P<message>.*)'
      - template:
          source: parser
          template: pgbouncer
      - labels:
          level:
          parser:
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsVeleroParser" -}}
- match:
    selector: '{container="velero"} |~ `^{"\w+":`'
    stages:
      - json:
          expressions:
            controller:
            level:
            message: msg
      - template:
          source: parser
          template: velero
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          controller:
          level:
          parser:
      - output:
          source: message
{{- end -}}

{{- define "promtail.podsGitLabServerParser" -}}
- match:
    selector: '{job=~".*gitlab.*"} |~ `^{"\w+":"`'
    stages:
      - template:
          source: parser
          template: gitlab-server
      - labels:
          parser:
{{- if .Values.pods.dropReadinessProbes }}
- match:
    selector: '{parser="gitlab-server"} |~ `[/"](readiness|liveness|metrics)`'
    stages:
      - drop:
          expression: '"status":200'
          drop_counter_reason: drop_readiness_probes
{{- end }}
- match:
    selector: '{parser="gitlab-server"} |~ `"(level|severity)":"\w+`'
    stages:
      - json:
          expressions:
            level:
            severity:
      - template:
          source: level
          template: {{ "'{{ if .severity }}{{ ToLower .severity }}{{ else }}{{ ToLower .Value }}{{ end }}'" }}
      - labeldrop:
          - severity
      {{- if .Values.pods.dropDebug }}
      - drop:
          source: level
          expression: debug
          drop_counter_reason: drop_debug
      {{- end }}
      - labels:
          level:
- match:
    selector: '{parser="gitlab-server",level=~".+",container=~".*workhorse.*"}'
    stages:
      - json:
          expressions:
            host:
            method:
            protocol: proto
            status:
            uri:
            user_agent:
            remote_ip:
      - template:
          source: parser
          template: gitlab-workhorse
      - template:
          source: message
          template: {{ "'{{ .remote_ip }} {{ .method }} {{ .uri }} | {{ .user_agent }}'" }}
      - labels:
          host:
          method:
          protocol:
          status:
          parser:
      - output:
          source: message
- match:
    selector: '{parser="gitlab-server",level="",container=~".*webservice.*"} |~ "path" |~ "remote_ip" |~ "username"'
    stages:
      - json:
          expressions:
            method:
            status:
            path:
            ua:
            remote_ip:
            username:
      - template:
          source: parser
          template: gitlab-webservice
      - template:
          source: message
          template: {{ "'{{ if .username }}{{ .username }}@{{ end }}{{ .remote_ip }} {{ .method }} {{ .path }} | {{ .ua }}'" }}
      - labels:
          method:
          status:
          parser:
      - output:
          source: message
- match:
    selector: '{parser="gitlab-server",level=~".+",container=~".*shell.*"}'
    stages:
      - json:
          expressions:
            method:
            status:
            message: msg
            url:
      - template:
          source: parser
          template: gitlab-shell
      - labels:
          method:
          status:
          parser:
      - replace:
          source: url
          expression: '(key=AAA[^&"]+)'
          replace: 'key=AAA...'
      - template:
          source: message
          template: {{ "'{{ .Value }}{{ if .url }} | {{ .url }}{{ end }}'" }}
      - output:
          source: message
- match:
    selector: '{parser="gitlab-server",level=~".+",container=~".*webservice.*"} |~ "method" |~ "params" |~ "path" |~ "remote_ip"'
    stages:
      - json:
          expressions:
            method:
            status:
            path:
            remote_ip:
            ua:
      - template:
          source: parser
          template: gitlab-webservice
      - labels:
          method:
          status:
          parser:
      - template:
          source: message
          template: {{ "'{{ .remote_ip }} {{ .method }} {{ .path }} | {{ .ua }}\n{{ .params }}'" }}
      - output:
          source: message
- match:
    selector: '{parser="gitlab-server",level=~".+",container=~".*sidekiq.*"}'
    stages:
      - json:
          expressions:
            class:
            message:
            queue:
      - template:
          source: parser
          template: gitlab-sidekiq
      - labels:
          class:
          queue:
          parser:
      - output:
          source: message
{{- end -}}
