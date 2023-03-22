{{/* vim: set filetype=mustache: */}}
{{- define "loki.storageConfig" -}}
{{- if .aws }}
aws:
  {{- if .aws.s3 }}
  s3: {{ .aws.s3 | toString }}
  {{- end }}
  s3forcepathstyle: {{ default false .aws.s3forcepathstyle | toString }}
  {{- if .aws.bucketnames }}
  bucketnames: {{ .aws.bucketnames | toString }}
  {{- end }}
  {{- if .aws.endpoint }}
  endpoint: {{ .aws.endpoint | toString }}
  {{- end }}
  {{- if .aws.region }}
  region: {{ .aws.region | toString }}
  {{- end }}
  {{- if .aws.accessKeyId }}
  access_key_id: {{ .aws.accessKeyId | toString }}
  {{- end }}
  {{- if .aws.secretAccessKey }}
  secret_access_key: {{ .aws.secretAccessKey | toString }}
  {{- end }}
  insecure: {{ default false .aws.insecure | toString }}
  sse_encryption: {{ default false .aws.sseEncryption | toString }}
  {{- if .aws.httpConfig }}
  http_config:
    idle_conn_timeout: {{ default "1m30s" .aws.httpConfig.idleConnTimeout | toString }}
    response_header_timeout: {{ default "0s" .aws.httpConfig.responseHeaderTimeout | toString }}
    insecure_skip_verify: {{ default false .aws.httpConfig.insecureSkipVerify | toString }}
  {{- end }}
  {{- if .aws.dynamodb }}
  dynamodb:
    {{- if .aws.dynamodb.dynamodbUrl }}
    dynamodb_url: {{ .aws.dynamodb.dynamodbUrl | toString }}
    {{- end }}
    api_limit: {{ default "2.0" .aws.dynamodb.apiLimit | float64 | toString }}
    throttle_limit: {{ default "10.0" .aws.dynamodb.throttleLimit | float64 | toString }}
    {{- if .aws.dynamodb.metrics }}
    metrics:
      {{- if .aws.dynamodb.metrics.url }}
      url: {{ .aws.dynamodb.metrics.url | toString }}
      {{- end }}
      target_queue_length: {{ default 100000 .aws.dynamodb.metrics.targetQueueLength | int64 | toString }}
      scale_up_factor: {{ default "1.3" .aws.dynamodb.metrics.scaleUpFactor | float64 | toString }}
      ignore_throttle_below: {{ default 1 .aws.dynamodb.metrics.ignoreThrottleBelow | float64 | toString }}
      queue_length_query: {{ default "sum(avg_over_time(cortex_ingester_flush_queue_length{job=\"cortex/ingester\"}[2m]))" .aws.dynamodb.metrics.queueLengthQuery | toString }}
      write_throttle_query: {{ default "sum(rate(cortex_dynamo_throttled_total{operation=\"DynamoDB.BatchWriteItem\"}[1m])) by (table) > 0" .aws.dynamodb.metrics.writeThrottleQuery | toString }}
      write_usage_query: {{ default "sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.BatchWriteItem\"}[15m])) by (table) > 0" .aws.dynamodb.metrics.writeUsageQuery | toString }}
      read_usage_query: {{ default "sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.QueryPages\"}[1h])) by (table) > 0" .aws.dynamodb.metrics.readUsageQuery | toString }}
      read_error_query: {{ default "sum(increase(cortex_dynamo_failures_total{operation=\"DynamoDB.QueryPages\",error=\"ProvisionedThroughputExceededException\"}[1m])) by (table) > 0" .aws.dynamodb.metrics.readErrorQuery | toString }}
    {{- end }}
    chunk_gang_size: {{ default 10 .aws.dynamodb.chunkGangSize | int64 | toString }}
    chunk_get_max_parallelism: {{ default 32 .aws.dynamodb.chunkGetMaxParallelism | int64 | toString }}
  {{- end }}
{{- end }}
{{- if .bigtable }}
bigtable:
  {{- if .bigtable.project }}
  project: {{ .bigtable.project | toString }}
  {{- end }}
  {{- if .bigtable.instance }}
  project: {{ .bigtable.instance | toString }}
  {{- end }}
  grpc_client_config:
    {{- include "loki.grpcClientConfig" .bigtable.grpcClientConfig | trim | nindent 4 }}
{{- end }}
{{- if .gcs }}
gcs:
  {{- if .gcs.bucketName }}
  bucket_name: {{ .gcs.bucketName | toString }}
  {{- end }}
  chunk_buffer_size: {{ default 0 .gcs.chunkBufferSize | int64 | toString }}
  request_timeout: {{ default "0s" .gcs.requestTimeout | toString }}
{{- end }}
{{- if .cassandra }}
cassandra:
  {{- if .cassandra.addresses }}
  addresses: {{ .cassandra.addresses | toString }}
  {{- end }}
  port: {{ default 9042 .cassandra.port | int64 | toString }}
  {{- if .cassandra.keyspace }}
  keyspace: {{ .cassandra.keyspace | toString }}
  {{- end }}
  consistency: {{ default "QUORUM" .cassandra.consistency | toString }}
  replication_factor: {{ default 1 .cassandra.replicationFactor | int64 | toString }}
  disable_initial_host_lookup: {{ default false .cassandra.disableInitialHostLookup | toString }}
  SSL: {{ default false .cassandra.ssl | toString }}
  host_verification: {{ default true .cassandra.hostVerification | toString }}
  {{- if .cassandra.caPath }}
  CA_path: {{ .cassandra.caPath | toString }}
  {{- end }}
  auth: {{ default false .cassandra.auth | toString }}
  {{- if .cassandra.username }}
  username: {{ .cassandra.username | toString }}
  {{- end }}
  {{- if .cassandra.password }}
  password: {{ .cassandra.password | toString }}
  {{- end }}
  timeout: {{ default "600ms" .cassandra.timeout | toString }}
  connect_timeout: {{ default "600ms" .cassandra.connectTimeout | toString }}
{{- end }}
{{- if .swift }}
swift:
  {{- if .swift.authUrl }}
  auth_url: {{ .swift.authUrl | toString }}
  {{- end }}
  {{- if .swift.username }}
  username: {{ .swift.username | toString }}
  {{- end }}
  {{- if .swift.userDomainName }}
  user_domain_name: {{ .swift.userDomainName | toString }}
  {{- end }}
  {{- if .swift.userDomainId }}
  user_domain_id: {{ .swift.userDomainId | toString }}
  {{- end }}
  {{- if .swift.userId }}
  user_id: {{ .swift.userId | toString }}
  {{- end }}
  {{- if .swift.password }}
  password: {{ .swift.password | toString }}
  {{- end }}
  {{- if .swift.domainId }}
  domain_id: {{ .swift.domainId | toString }}
  {{- end }}
  {{- if .swift.domainName }}
  domain_name: {{ .swift.domainName | toString }}
  {{- end }}
  {{- if .swift.projectId }}
  project_id: {{ .swift.projectId | toString }}
  {{- end }}
  {{- if .swift.projectName }}
  project_name: {{ .swift.projectName | toString }}
  {{- end }}
  {{- if .swift.projectDomainId }}
  project_domain_id: {{ .swift.projectDomainId | toString }}
  {{- end }}
  {{- if .swift.projectDomainName }}
  project_domain_name: {{ .swift.projectDomainName | toString }}
  {{- end }}
  {{- if .swift.regionName }}
  region_name: {{ .swift.regionName | toString }}
  {{- end }}
  container_name: {{ default "cortex" .swift.containerName | toString }}
{{- end }}
{{- if .boltdb }}
boltdb:
  {{- if .boltdb.directory }}
  directory: {{ default "" .boltdb.directory | toString }}
  {{- end }}
{{- end }}
{{- if .boltdbShipper }}
boltdb_shipper:
  cache_ttl: {{ default "24h" .boltdbShipper.cacheTtl | toString }}
  {{- if .boltdbShipper.activeIndexDirectory }}
  active_index_directory: {{ default "" .boltdbShipper.activeIndexDirectory | toString }}
  {{- end }}
  {{- if .boltdbShipper.sharedStore }}
  shared_store: {{ default "" .boltdbShipper.sharedStore | toString }}
  {{- end }}
  {{- if .boltdbShipper.cacheLocation }}
  cache_location: {{ default "" .boltdbShipper.cacheLocation | toString }}
  {{- end }}
  resync_interval: {{ default "5m" .boltdbShipper.resyncInterval | toString }}
  query_ready_num_days: {{ default "0" .boltdbShipper.queryReadyNumDays | toString }}
{{- end }}
{{- if .filesystem }}
filesystem:
  directory: {{ default "" .filesystem.directory | toString }}
{{- end }}
index_cache_validity: {{ default "5m" .indexCacheValidity | toString }}
max_chunk_batch_size: {{ default 50 .maxChunkBatchSize | int64 | toString }}
{{- if .indexQueriesCacheConfig }}
index_queries_cache_config:
  {{- include "loki.cacheConfig" .indexQueriesCacheConfig | trim | nindent 2 }}
{{- end }}
{{- end -}}
