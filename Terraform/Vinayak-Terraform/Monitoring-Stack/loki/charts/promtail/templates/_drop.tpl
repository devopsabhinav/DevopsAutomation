{{- define "promtail.podsDropDebug" -}}
- match:
    selector: '{pod=~".+"} |~ `\b(level=debug|debug=true)\b`'
    stages:
      - drop:
          expression: .*
          drop_counter_reason: drop_debug
- match:
    selector: '{pod=~".+"} |~ `^(DEBUG|level=debug|{"level":"debug)\b`'
    stages:
      - drop:
          expression: .*
          drop_counter_reason: drop_debug
- match:
    selector: '{level="debug"}'
    stages:
      - drop:
          source: level
          expression: debug
- match:
    selector: '{debug="true"}'
    stages:
      - drop:
          source: level
          expression: debug
- match:
    selector: '{pod=~".+"} |~ `^[\.-]+$`'
    stages:
      - drop:
          expression: .*
          drop_counter_reason: drop_debug
{{- end -}}

{{- define "promtail.podsDropReadinessProbes" -}}
- match:
    selector: '{pod=~".+"} |= "GET /"'
    stages:
      - drop:
          expression: '"kube-probe/1.[0-9]+"'
          drop_counter_reason: drop_readiness_probes
      - drop:
          expression: '^127.0.0.1 .* 200 '
          drop_counter_reason: drop_readiness_probes
      - drop:
          expression: 'GET /(healthz|ping|ready)\b.* 200 '
          drop_counter_reason: drop_readiness_probes
{{- end -}}

{{- define "promtail.podsDropDeprecated" -}}
- match:
    selector: '{pod=~".+"} |~ `\b[Dd][Ee][Pp][Rr][Ee][Cc][Aa][Tt][Ee][Dd]\b`'
    stages:
      - drop:
          expression: .*
          drop_counter_reason: drop_deprecated
{{- end -}}
