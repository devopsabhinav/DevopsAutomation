{{/* vim: set filetype=mustache: */}}
{{- define "loki.memberlistConfig" -}}
{{- if .nodeName }}
node_name: {{ .nodeName | toString }}
{{- end }}
{{- if not (empty .randomizeNodeName) }}
randomize_node_name: {{ .randomizeNodeName | toString }}
{{- end }}
stream_timeout: {{ default "0s" .streamTimeout | toString }}
retransmit_factor: {{ default 0 .retransmitFactor | int64 | toString }}
pull_push_interval: {{ default "0s" .pullPushInterval | toString }}
gossip_interval: {{ default "0s" .gossipInterval | toString }}
gossip_nodes: {{ default 0 .gossipNodes | int64 | toString }}
gossip_to_dead_nodes_time: {{ default "0s" .gossipToDeadNodesTime | toString }}
dead_node_reclaim_time: {{ default "0s" .deadNodeReclaimTime | toString }}
{{- if .joinMembers }}
join_members: {{ .joinMembers | toString }}
{{- end }}
min_join_backoff: {{ default "1s" .minJoinBackoff | toString }}
max_join_backoff: {{ default "1m" .maxJoinBackoff | toString }}
max_join_retries: {{ default 10 .maxJoinRetries | int64 | toString }}
{{- if not (empty .abortIfClusterJoinFails) }}
abort_if_cluster_join_fails: {{ .abortIfClusterJoinFails | toString }}
{{- end }}
rejoin_interval: {{ default "0s" .rejoinInterval | toString }}
left_ingesters_timeout: {{ default "5m" .leftIngestersTimeout | toString }}
leave_timeout: {{ default "5s" .leaveTimeout | toString }}
bind_addr: {{ default "0.0.0.0" .bindAddr | toString }}
bind_port: {{ default 7946 .bindPort | int64 | toString }}
packet_dial_timeout: {{ default "5s" .packetDialTimeout | toString }}
packet_write_timeout: {{ default "5s" .packetWriteTimeout | toString }}
{{- end -}}
