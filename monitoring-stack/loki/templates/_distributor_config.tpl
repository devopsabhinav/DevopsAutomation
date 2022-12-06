{{/* vim: set filetype=mustache: */}}
{{- define "loki.distributorConfig" -}}
ring:
  heartbeat_timeout: {{ default "1m" .ring.heartbeatTimeout | toString }}
  kvstore:
    store: {{ default "inmemory" .ring.kvstore.store | toString }}
    {{- if .ring.kvstore.prefix }}
    prefix: {{ .ring.kvstore.prefix | toString }}
    {{- end }}
    {{- if eq .ring.kvstore.store "consul" }}
    consul:
      {{- include "loki.consulConfig" .ring.kvstore.consul | trim | nindent 6 }}
    {{- end }}
    {{- if eq .ring.kvstore.store "etcd" }}
    etcd:
      {{- include "loki.etcdConfig" .ring.kvstore.etcd | trim | nindent 6 }}
    {{- end }}
    {{- if eq .ring.kvstore.store "memberlist" }}
    memberlist:
      {{- include "loki.memberlistConfig" .ring.kvstore.memberlist | trim | nindent 6 }}
    {{- end }}
{{- end -}}
