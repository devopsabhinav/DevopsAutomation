# loki

[![Version: 1.7.3](https://img.shields.io/badge/Version-1.7.3-informational?style=flat-square) ](#)
[![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ](#)
[![AppVersion: 2.2.1](https://img.shields.io/badge/AppVersion-2.2.1-informational?style=flat-square) ](#)
[![Artifact Hub: kube-ops](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kube-ops&style=flat-square)](https://artifacthub.io/packages/helm/kube-ops/loki)

Loki: like Prometheus, but for logs.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add kube-ops https://charts.kube-ops.io
$ helm repo update
$ helm upgrade my-release kube-ops/loki --install --namespace my-namespace --create-namespace --wait
```

## Uninstalling the Chart

To uninstall the chart:

```console
$ helm uninstall my-release --namespace my-namespace
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| alertingGroups | list | `[]` |  |
| annotations | object | `{}` |  |
| authEnabled | bool | `false` | Enables authentication through the X-Scope-OrgID header, which must be present if true. If false, the OrgID will always be set to "fake". |
| autoscaling.enabled | bool | `false` | Specifies the horizontal pod autoscaling is enabled |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| chunkStoreConfig | object | `{"cacheLookupsOlderThan":"0s","chunkCacheConfig":{"background":{"writebackBuffer":10000,"writebackGoroutines":10},"defaultValidity":"1h","enableFifocache":false,"fifocache":{"maxSizeBytes":"","maxSizeItems":0,"validity":"0s"},"memcached":{"batchSize":262144,"expiration":"1h","parallelism":100},"memcachedClient":{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"},"redis":{"db":1,"endpoint":"","expiration":"0s","idleTimeout":"0s","masterName":"","maxConnectionAge":"0s","password":"","poolSize":0,"timeout":"100ms"}},"maxLookBackPeriod":"0s","writeDedupeCacheConfig":{"background":{"writebackBuffer":10000,"writebackGoroutines":10},"defaultValidity":"1h","enableFifocache":false,"fifocache":{"maxSizeBytes":"","maxSizeItems":0,"validity":"0s"},"memcached":{"batchSize":262144,"expiration":"1h","parallelism":100},"memcachedClient":{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"},"redis":{"db":1,"endpoint":"","expiration":"0s","idleTimeout":"0s","masterName":"","maxConnectionAge":"0s","password":"","poolSize":0,"timeout":"100ms"}}}` | Configures how Loki will store data in the specific store. |
| chunkStoreConfig.cacheLookupsOlderThan | string | `"0s"` | Cache index entries older than this period. Default is disabled. |
| chunkStoreConfig.chunkCacheConfig | object | `{"background":{"writebackBuffer":10000,"writebackGoroutines":10},"defaultValidity":"1h","enableFifocache":false,"fifocache":{"maxSizeBytes":"","maxSizeItems":0,"validity":"0s"},"memcached":{"batchSize":262144,"expiration":"1h","parallelism":100},"memcachedClient":{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"},"redis":{"db":1,"endpoint":"","expiration":"0s","idleTimeout":"0s","masterName":"","maxConnectionAge":"0s","password":"","poolSize":0,"timeout":"100ms"}}` | The cache configuration for storing chunks |
| chunkStoreConfig.chunkCacheConfig.background | object | `{"writebackBuffer":10000,"writebackGoroutines":10}` | Configures the background cache when memcached is used. |
| chunkStoreConfig.chunkCacheConfig.background.writebackBuffer | int | `10000` | How many chunks to buffer for background write back to memcached. |
| chunkStoreConfig.chunkCacheConfig.background.writebackGoroutines | int | `10` | How many goroutines to use to write back to memcached. |
| chunkStoreConfig.chunkCacheConfig.defaultValidity | string | `"1h"` | The default validity of entries for caches unless overridden. |
| chunkStoreConfig.chunkCacheConfig.enableFifocache | bool | `false` | Enable in-memory cache. |
| chunkStoreConfig.chunkCacheConfig.fifocache.maxSizeBytes | string | `""` | Maximum number of entries in the cache. |
| chunkStoreConfig.chunkCacheConfig.fifocache.validity | string | `"0s"` | The expiry duration for the cache. |
| chunkStoreConfig.chunkCacheConfig.memcached | object | `{"batchSize":262144,"expiration":"1h","parallelism":100}` | Configures memcached settings. |
| chunkStoreConfig.chunkCacheConfig.memcached.batchSize | int | `262144` | Configures how many keys to fetch in each batch request. |
| chunkStoreConfig.chunkCacheConfig.memcached.expiration | string | `"1h"` | Configures how long keys stay in memcached. |
| chunkStoreConfig.chunkCacheConfig.memcached.parallelism | int | `100` | Maximum active requests to memcached. |
| chunkStoreConfig.chunkCacheConfig.memcachedClient | object | `{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"}` | Configures how to connect to one or more memcached servers. |
| chunkStoreConfig.chunkCacheConfig.memcachedClient.consistentHash | bool | `true` | Whether or not to use a consistent hash to discover multiple memcached servers. |
| chunkStoreConfig.chunkCacheConfig.memcachedClient.host | string | `""` | The hostname to use for memcached services when caching chunks. If empty, no memcached will be used. A SRV lookup will be used. |
| chunkStoreConfig.chunkCacheConfig.memcachedClient.maxIdleConns | int | `100` | The maximum number of idle connections in the memcached client pool. |
| chunkStoreConfig.chunkCacheConfig.memcachedClient.service | string | `"memcached"` | SRV service used to discover memcached servers. |
| chunkStoreConfig.chunkCacheConfig.memcachedClient.timeout | string | `"100ms"` | Maximum time to wait before giving up on memcached requests. |
| chunkStoreConfig.chunkCacheConfig.memcachedClient.updateInterval | string | `"1m"` | The period with which to poll the DNS for memcached servers. |
| chunkStoreConfig.chunkCacheConfig.redis.db | int | `1` | Database index. |
| chunkStoreConfig.chunkCacheConfig.redis.endpoint | string | `""` | Redis Server endpoint to use for caching. A comma-separated list of endpoints for Redis Cluster or Redis Sentinel. If empty, no redis will be used. |
| chunkStoreConfig.chunkCacheConfig.redis.expiration | string | `"0s"` | How long keys stay in the redis. |
| chunkStoreConfig.chunkCacheConfig.redis.idleTimeout | string | `"0s"` | Close connections after remaining idle for this duration. If the value is zero, then idle connections are not closed. |
| chunkStoreConfig.chunkCacheConfig.redis.masterName | string | `""` | Redis Sentinel master name. An empty string for Redis Server or Redis Cluster. |
| chunkStoreConfig.chunkCacheConfig.redis.maxConnectionAge | string | `"0s"` | Close connections older than this duration. If the value is zero, then the pool does not close connections based on age. |
| chunkStoreConfig.chunkCacheConfig.redis.password | string | `""` | Password to use when connecting to redis. |
| chunkStoreConfig.chunkCacheConfig.redis.poolSize | int | `0` | Maximum number of connections in the pool. |
| chunkStoreConfig.chunkCacheConfig.redis.timeout | string | `"100ms"` | Maximum time to wait before giving up on redis requests. |
| chunkStoreConfig.maxLookBackPeriod | string | `"0s"` | Limit how long back data can be queried. Default is disabled. This should always be set to a value less than or equal to what is set in `tableManager.retentionPeriod` . |
| chunkStoreConfig.writeDedupeCacheConfig | object | `{"background":{"writebackBuffer":10000,"writebackGoroutines":10},"defaultValidity":"1h","enableFifocache":false,"fifocache":{"maxSizeBytes":"","maxSizeItems":0,"validity":"0s"},"memcached":{"batchSize":262144,"expiration":"1h","parallelism":100},"memcachedClient":{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"},"redis":{"db":1,"endpoint":"","expiration":"0s","idleTimeout":"0s","masterName":"","maxConnectionAge":"0s","password":"","poolSize":0,"timeout":"100ms"}}` | The cache configuration for deduplicating writes |
| chunkStoreConfig.writeDedupeCacheConfig.background | object | `{"writebackBuffer":10000,"writebackGoroutines":10}` | Configures the background cache when memcached is used. |
| chunkStoreConfig.writeDedupeCacheConfig.background.writebackBuffer | int | `10000` | How many chunks to buffer for background write back to memcached. |
| chunkStoreConfig.writeDedupeCacheConfig.background.writebackGoroutines | int | `10` | How many goroutines to use to write back to memcached. |
| chunkStoreConfig.writeDedupeCacheConfig.defaultValidity | string | `"1h"` | The default validity of entries for caches unless overridden. |
| chunkStoreConfig.writeDedupeCacheConfig.enableFifocache | bool | `false` | Enable in-memory cache. |
| chunkStoreConfig.writeDedupeCacheConfig.fifocache.maxSizeBytes | string | `""` | Maximum number of entries in the cache. |
| chunkStoreConfig.writeDedupeCacheConfig.fifocache.validity | string | `"0s"` | The expiry duration for the cache. |
| chunkStoreConfig.writeDedupeCacheConfig.memcached | object | `{"batchSize":262144,"expiration":"1h","parallelism":100}` | Configures memcached settings. |
| chunkStoreConfig.writeDedupeCacheConfig.memcached.batchSize | int | `262144` | Configures how many keys to fetch in each batch request. |
| chunkStoreConfig.writeDedupeCacheConfig.memcached.expiration | string | `"1h"` | Configures how long keys stay in memcached. |
| chunkStoreConfig.writeDedupeCacheConfig.memcached.parallelism | int | `100` | Maximum active requests to memcached. |
| chunkStoreConfig.writeDedupeCacheConfig.memcachedClient | object | `{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"}` | Configures how to connect to one or more memcached servers. |
| chunkStoreConfig.writeDedupeCacheConfig.memcachedClient.consistentHash | bool | `true` | Whether or not to use a consistent hash to discover multiple memcached servers. |
| chunkStoreConfig.writeDedupeCacheConfig.memcachedClient.host | string | `""` | The hostname to use for memcached services when caching chunks. If empty, no memcached will be used. A SRV lookup will be used. |
| chunkStoreConfig.writeDedupeCacheConfig.memcachedClient.maxIdleConns | int | `100` | The maximum number of idle connections in the memcached client pool. |
| chunkStoreConfig.writeDedupeCacheConfig.memcachedClient.service | string | `"memcached"` | SRV service used to discover memcached servers. |
| chunkStoreConfig.writeDedupeCacheConfig.memcachedClient.timeout | string | `"100ms"` | Maximum time to wait before giving up on memcached requests. |
| chunkStoreConfig.writeDedupeCacheConfig.memcachedClient.updateInterval | string | `"1m"` | The period with which to poll the DNS for memcached servers. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.db | int | `1` | Database index. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.endpoint | string | `""` | Redis Server endpoint to use for caching. A comma-separated list of endpoints for Redis Cluster or Redis Sentinel. If empty, no redis will be used. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.expiration | string | `"0s"` | How long keys stay in the redis. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.idleTimeout | string | `"0s"` | Close connections after remaining idle for this duration. If the value is zero, then idle connections are not closed. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.masterName | string | `""` | Redis Sentinel master name. An empty string for Redis Server or Redis Cluster. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.maxConnectionAge | string | `"0s"` | Close connections older than this duration. If the value is zero, then the pool does not close connections based on age. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.password | string | `""` | Password to use when connecting to redis. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.poolSize | int | `0` | Maximum number of connections in the pool. |
| chunkStoreConfig.writeDedupeCacheConfig.redis.timeout | string | `"100ms"` | Maximum time to wait before giving up on redis requests. |
| compactor | object | `{}` |  |
| deploymentType | string | `"StatefulSet"` |  |
| distributor | object | `{}` |  |
| dnsConfig | object | `{}` |  |
| dnsPolicy | string | `""` |  |
| ephemeralContainers | list | `[]` |  |
| extraArgs | list | `[]` | Additional CLI arguments for application |
| extraContainers | list | `[]` | Specifies additional containers |
| extraEnvVars | list | `[]` | Additional environment variables |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` | Additional mounts for application |
| frontend | object | `{"compressResponses":false,"downstreamUrl":"","logQueriesLongerThan":"0s","maxOutstandingPerTenant":100}` | Configures the Loki query-frontend. |
| frontend.compressResponses | bool | `false` | Compress HTTP responses. |
| frontend.downstreamUrl | string | `""` | URL of downstream Prometheus. |
| frontend.logQueriesLongerThan | string | `"0s"` | Log queries that are slower than the specified duration. Set to 0 to disable. Set to < 0 to enable on all queries. |
| frontend.maxOutstandingPerTenant | int | `100` | Maximum number of outstanding requests per tenant per frontend; requests beyond this error with HTTP 429. |
| frontendWorker | object | `{}` |  |
| fullnameOverride | string | `""` | Overrides the full name |
| global.imagePullPolicy | string | `"IfNotPresent"` | Image download policy ref: https://kubernetes.io/docs/concepts/containers/images/#updating-images |
| global.imagePullSecrets | list | `[]` | List of the Docker registry credentials ref: https://kubernetes.io/docs/concepts/containers/images/#updating-images |
| hostAliases | list | `[]` |  |
| image.repository | string | `"quay.io/kube-ops/loki"` | Overrides the image repository |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| ingester | object | `{"chunkBlockSize":262144,"chunkEncoding":"gzip","chunkIdlePeriod":"30m","chunkRetainPeriod":"15m","chunkTargetSize":1536000,"concurrentFlushes":16,"flushCheckPeriod":"30s","flushOpTimeout":"10s","lifecycler":{"finalSleep":"30s","heartbeatPeriod":"5s","interfaceNames":[],"joinAfter":"0s","minReadyDuration":"1m","numTokens":128,"ring":{"heartbeatTimeout":"1m","kvstore":{"consul":{"aclToken":"","consistentReads":true,"host":"localhost:8500","httpClientTimeout":"20s"},"etcd":{"dialTimeout":"10s","endpoints":[],"maxRetries":10},"memberlist":{"abortIfClusterJoinFails":true,"bindAddr":"0.0.0.0","bindPort":7946,"deadNodeReclaimTime":"0s","gossipInterval":"0s","gossipNodes":0,"gossipToDeadNodesTime":"0s","joinMembers":"","leaveTimeout":"5s","leftIngestersTimeout":"5m","maxJoinBackoff":"1m","maxJoinRetries":10,"minJoinBackoff":"1s","nodeName":"","packetDialTimeout":"5s","packetWriteTimeout":"5s","pullPushInterval":"0s","randomizeNodeName":true,"rejoinInterval":"0s","retransmitFactor":0,"streamTimeout":"0s"},"prefix":"collectors/","store":"inmemory"},"replicationFactor":1}},"maxChunkAge":"1h","maxReturnedStreamErrors":10,"maxTransferRetries":10,"queryStoreMaxLookBackPeriod":"0s","syncMinUtilization":0,"syncPeriod":"0s"}` | Configures the ingester and how the ingester will register itself to a key value store. |
| ingester.chunkBlockSize | int | `262144` | The targeted uncompressed size in bytes of a chunk block. When this threshold is exceeded the head block will be cut and compressed inside the chunk. |
| ingester.chunkEncoding | string | `"gzip"` | The compression algorithm to use for chunks. (supported: gzip, lz4, snappy) You should choose your algorithm depending on your need: - `gzip` highest compression ratio but also slowest decompression speed. (144 kB per chunk) - `lz4` fastest compression speed (188 kB per chunk) - `snappy` fast and popular compression algorithm (272 kB per chunk) |
| ingester.chunkIdlePeriod | string | `"30m"` | How long chunks should sit in-memory with no updates before being flushed if they don't hit the max block size. This means that half-empty chunks will still be flushed after a certain period as long as they receive no further activity. |
| ingester.chunkRetainPeriod | string | `"15m"` | How long chunks should be retained in-memory after they've been flushed. |
| ingester.chunkTargetSize | int | `1536000` | A target compressed size in bytes for chunks. This is a desired size not an exact size, chunks may be slightly bigger or significantly smaller if they get flushed for other reasons (e.g. chunkIdlePeriod). The default value of 0 for this will create chunks with a fixed 10 blocks, a non zero value will create chunks with a variable number of blocks to meet the target size. |
| ingester.concurrentFlushes | int | `16` | How many flushes can happen concurrently from each stream. |
| ingester.flushCheckPeriod | string | `"30s"` | How often should the ingester see if there are any blocks to flush |
| ingester.flushOpTimeout | string | `"10s"` | The timeout before a flush is cancelled |
| ingester.lifecycler.finalSleep | string | `"30s"` | Duration to sleep before exiting to ensure metrics are scraped. |
| ingester.lifecycler.heartbeatPeriod | string | `"5s"` | Period at which to heartbeat to the underlying ring. |
| ingester.lifecycler.interfaceNames | list | `[]` | Name of network interfaces to read addresses from. |
| ingester.lifecycler.joinAfter | string | `"0s"` | How long to wait to claim tokens and chunks from another member when that member is leaving. Will join automatically after the duration expires. |
| ingester.lifecycler.numTokens | int | `128` | Minimum duration to wait before becoming ready. This is to work around race conditions with ingesters exiting and updating the ring. |
| ingester.lifecycler.ring.heartbeatTimeout | string | `"1m"` | The heartbeat timeout after which ingesters are skipped for reads/writes. |
| ingester.lifecycler.ring.kvstore.consul | object | `{"aclToken":"","consistentReads":true,"host":"localhost:8500","httpClientTimeout":"20s"}` | Configuration for a Consul client. Only applies if store is "consul" |
| ingester.lifecycler.ring.kvstore.consul.aclToken | string | `""` | The ACL Token used to interact with Consul. |
| ingester.lifecycler.ring.kvstore.consul.consistentReads | bool | `true` | Whether or not consistent reads to Consul are enabled. |
| ingester.lifecycler.ring.kvstore.consul.host | string | `"localhost:8500"` | The hostname and port of Consul. |
| ingester.lifecycler.ring.kvstore.consul.httpClientTimeout | string | `"20s"` | The HTTP timeout when communicating with Consul |
| ingester.lifecycler.ring.kvstore.etcd | object | `{"dialTimeout":"10s","endpoints":[],"maxRetries":10}` | Configuration for an ETCD v3 client. Only applies if store is "etcd" |
| ingester.lifecycler.ring.kvstore.etcd.dialTimeout | string | `"10s"` | The dial timeout for the etcd connection. |
| ingester.lifecycler.ring.kvstore.etcd.endpoints | list | `[]` | The etcd endpoints to connect to. |
| ingester.lifecycler.ring.kvstore.etcd.maxRetries | int | `10` | The maximum number of retries to do for failed ops. |
| ingester.lifecycler.ring.kvstore.memberlist | object | `{"abortIfClusterJoinFails":true,"bindAddr":"0.0.0.0","bindPort":7946,"deadNodeReclaimTime":"0s","gossipInterval":"0s","gossipNodes":0,"gossipToDeadNodesTime":"0s","joinMembers":"","leaveTimeout":"5s","leftIngestersTimeout":"5m","maxJoinBackoff":"1m","maxJoinRetries":10,"minJoinBackoff":"1s","nodeName":"","packetDialTimeout":"5s","packetWriteTimeout":"5s","pullPushInterval":"0s","randomizeNodeName":true,"rejoinInterval":"0s","retransmitFactor":0,"streamTimeout":"0s"}` | Configuration for Gossip memberlist. Only applies if store is "memberlist" |
| ingester.lifecycler.ring.kvstore.memberlist.abortIfClusterJoinFails | bool | `true` | If this node fails to join memberlist cluster, abort. |
| ingester.lifecycler.ring.kvstore.memberlist.bindPort | int | `7946` | Port to listen on for gossip messages. |
| ingester.lifecycler.ring.kvstore.memberlist.deadNodeReclaimTime | string | `"0s"` | How soon can dead node's name be reclaimed with new address. Defaults to 0, which is disabled. |
| ingester.lifecycler.ring.kvstore.memberlist.gossipInterval | string | `"0s"` | How often to gossip. Uses memberlist LAN defaults if 0. |
| ingester.lifecycler.ring.kvstore.memberlist.gossipNodes | int | `0` | How many nodes to gossip to. Uses memberlist LAN defaults if 0. |
| ingester.lifecycler.ring.kvstore.memberlist.gossipToDeadNodesTime | string | `"0s"` | How long to keep gossiping to dead nodes, to give them chance to refute their death. Uses memberlist LAN defaults if 0. |
| ingester.lifecycler.ring.kvstore.memberlist.joinMembers | string | `""` | Other cluster members to join. Can be specified multiple times. It can be an IP, hostname or an entry specified in the DNS Service Discovery format (see https://cortexmetrics.io/docs/configuration/arguments/#dns-service-discovery for more details). |
| ingester.lifecycler.ring.kvstore.memberlist.leaveTimeout | string | `"5s"` | Timeout for leaving memberlist cluster. |
| ingester.lifecycler.ring.kvstore.memberlist.leftIngestersTimeout | string | `"5m"` | How long to keep LEFT ingesters in the ring. |
| ingester.lifecycler.ring.kvstore.memberlist.maxJoinBackoff | string | `"1m"` | Max backoff duration to join other cluster members. |
| ingester.lifecycler.ring.kvstore.memberlist.maxJoinRetries | int | `10` | Max number of retries to join other cluster members. |
| ingester.lifecycler.ring.kvstore.memberlist.minJoinBackoff | string | `"1s"` | Min backoff duration to join other cluster members. |
| ingester.lifecycler.ring.kvstore.memberlist.nodeName | string | `""` | Name of the node in memberlist cluster. Defaults to hostname. |
| ingester.lifecycler.ring.kvstore.memberlist.packetDialTimeout | string | `"5s"` | Timeout used when connecting to other nodes to send packet. |
| ingester.lifecycler.ring.kvstore.memberlist.packetWriteTimeout | string | `"5s"` | Timeout for writing 'packet' data. |
| ingester.lifecycler.ring.kvstore.memberlist.pullPushInterval | string | `"0s"` | How often to use pull/push sync. Uses memberlist LAN defaults if 0. |
| ingester.lifecycler.ring.kvstore.memberlist.randomizeNodeName | bool | `true` | Add random suffix to the node name. |
| ingester.lifecycler.ring.kvstore.memberlist.rejoinInterval | string | `"0s"` | If not 0, how often to rejoin the cluster. Occasional rejoin can help to fix the cluster split issue, and is harmless otherwise. For example when using only few components as a seed nodes (via -memberlist.join), then it's recommended to use rejoin. If -memberlist.join points to dynamic service that resolves to all gossiping nodes (eg. Kubernetes headless service), then rejoin is not needed. |
| ingester.lifecycler.ring.kvstore.memberlist.retransmitFactor | int | `0` | Multiplication factor used when sending out messages (factor * log(N+1)). |
| ingester.lifecycler.ring.kvstore.memberlist.streamTimeout | string | `"0s"` | The timeout for establishing a connection with a remote node, and for read/write operations. Uses memberlist LAN defaults if 0. |
| ingester.lifecycler.ring.kvstore.prefix | string | `"collectors/"` | The prefix for the keys in the store. Should end with a /. |
| ingester.lifecycler.ring.kvstore.store | string | `"inmemory"` | Backend storage to use for the ring. Supported values are: consul, etcd, inmemory, memberlist |
| ingester.lifecycler.ring.replicationFactor | int | `1` | The heartbeat timeout after which ingesters are skipped for reads/writes. |
| ingester.maxChunkAge | string | `"1h"` | The maximum duration of a timeseries chunk in memory. If a timeseries runs for longer than this the current chunk will be flushed to the store and a new chunk created. |
| ingester.maxReturnedStreamErrors | int | `10` | The maximum number of errors a stream will report to the user when a push fails. 0 to make unlimited. |
| ingester.maxTransferRetries | int | `10` | Number of times to try and transfer chunks when leaving before falling back to flushing to the store. Zero = no transfers are done. |
| ingester.queryStoreMaxLookBackPeriod | string | `"0s"` | How far in the past an ingester is allowed to query the store for data. This is only useful for running multiple loki binaries with a shared ring with a `filesystem` store which is NOT shared between the binaries When using any "shared" object store like S3 or GCS this value must always be left as 0 It is an error to configure this to a non-zero value when using any object store other than `filesystem` Use a value of -1 to allow the ingester to query the store infinitely far back in time. |
| ingester.syncPeriod | string | `"0s"` | Parameters used to synchronize ingesters to cut chunks at the same moment. Sync period is used to roll over incoming entry to a new chunk. If chunk's utilization isn't high enough (eg. less than 50% when syncMinUtilization is set to 0.5), then this chunk rollover doesn't happen. |
| ingesterClient | object | `{}` | Configures how the distributor will connect to ingesters. Only appropriate when running all modules, the distributor, or the querier. |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` | Specifies whether a ingress should be created |
| ingress.hosts[0].host | string | `"chart-template.example.com"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| ingress.labels | object | `{}` |  |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` | Specifies init containers |
| labels | object | `{}` |  |
| limitsConfig | object | `{"cardinalityLimit":100000,"creationGracePeriod":"10m","enforceMetricName":false,"ingestionBurstSizeMb":6,"ingestionRateMb":4,"ingestionRateStrategy":"local","maxChunksPerQuery":2000000,"maxEntriesLimitPerQuery":5000,"maxGlobalStreamsPerUser":0,"maxLabelNameLength":1024,"maxLabelNamesPerSeries":30,"maxLabelValueLength":2048,"maxLineSize":null,"maxQueryLength":"0s","maxQueryParallelism":14,"maxStreamsMatchersPerQuery":1000,"maxStreamsPerUser":10000,"perTenantOverrideConfig":"","perTenantOverridePeriod":"10s","rejectOldSamples":true,"rejectOldSamplesMaxAge":"336h"}` | Configures limits per-tenant or globally |
| limitsConfig.cardinalityLimit | int | `100000` | Cardinality limit for index queries. |
| limitsConfig.creationGracePeriod | string | `"10m"` | Duration for a table to be created/deleted before/after it's needed. Samples won't be accepted before this time. |
| limitsConfig.enforceMetricName | bool | `false` | Enforce every sample has a metric name. |
| limitsConfig.ingestionBurstSizeMb | int | `6` | Per-user allowed ingestion burst size (in sample size). Units in MB. The burst size refers to the per-distributor local rate limiter even in the case of the "global" strategy, and should be set at least to the maximum logs size expected in a single push request. |
| limitsConfig.ingestionRateMb | float | `4` | Per-user ingestion rate limit in sample size per second. Units in MB. |
| limitsConfig.ingestionRateStrategy | string | `"local"` | Whether the ingestion rate limit should be applied individually to each distributor instance (local), or evenly shared across the cluster (global). The ingestion rate strategy cannot be overridden on a per-tenant basis. |
| limitsConfig.maxChunksPerQuery | int | `2000000` | Maximum number of chunks that can be fetched by a single query. |
| limitsConfig.maxEntriesLimitPerQuery | int | `5000` | Maximum number of log entries that will be returned for a query. |
| limitsConfig.maxGlobalStreamsPerUser | int | `0` | Maximum number of active streams per user, across the cluster. 0 to disable. When the global limit is enabled, each ingester is configured with a dynamic local limit based on the replication factor and the current number of healthy ingesters, and is kept updated whenever the number of ingesters change. |
| limitsConfig.maxLabelNameLength | int | `1024` | Maximum length of a label name. |
| limitsConfig.maxLabelNamesPerSeries | int | `30` | Maximum number of label names per series. |
| limitsConfig.maxLabelValueLength | int | `2048` | Maximum length of a label value. |
| limitsConfig.maxLineSize | str | `nil` | Maximum line size on ingestion path. Example: 256kb. There is no limit when unset. |
| limitsConfig.maxQueryLength | string | `"0s"` | The limit to length of chunk store queries. 0 to disable. |
| limitsConfig.maxQueryParallelism | int | `14` | Maximum number of queries that will be scheduled in parallel by the frontend. |
| limitsConfig.maxStreamsMatchersPerQuery | int | `1000` | Maximum number of stream matchers per query. |
| limitsConfig.maxStreamsPerUser | int | `10000` | Maximum number of active streams per user, per ingester. 0 to disable. |
| limitsConfig.perTenantOverrideConfig | string | `""` | Feature renamed to 'runtime configuration', flag deprecated in favor of -runtime-config.file (runtime_config.file in YAML). |
| limitsConfig.perTenantOverridePeriod | string | `"10s"` | Feature renamed to 'runtime configuration', flag deprecated in favor of -runtime-config.reload-period (runtime_config.period in YAML). |
| limitsConfig.rejectOldSamples | bool | `true` | Whether or not old samples will be rejected. |
| limitsConfig.rejectOldSamplesMaxAge | string | `"336h"` | Maximum accepted sample age before rejecting. |
| logLevel | string | `"warn"` |  |
| nameOverride | string | `""` | Overrides the chart name |
| networkPolicy.annotations | object | `{}` | Annotations for NetworkPolicy |
| networkPolicy.egress | list | `[{}]` | Egress rules |
| networkPolicy.enabled | bool | `false` | Specifies whether a NetworkPolicy should be created |
| networkPolicy.ingress | list | `[{}]` | Ingress rules |
| networkPolicy.labels | object | `{}` | Additional labels for NetworkPolicy |
| nodeSelector | object | `{}` |  |
| pdb.enabled | bool | `false` | Specifies whether a pod disruption budget should be created |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.dataSource | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.selector | object | `{}` |  |
| persistence.size | string | `"8Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| persistence.volumeMode | string | `"Filesystem"` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podManagementPolicy | string | `"OrderedReady"` | Specifies the strategy used to replace old Pods by new ones |
| podSecurityContext | object | `{"fsGroup":10001,"runAsNonRoot":true}` | Pod security settings |
| podSecurityPolicy.annotations | object | `{}` |  |
| podSecurityPolicy.create | bool | `true` | Specifies whether a pod security policy should be created |
| podSecurityPolicy.enabled | bool | `true` | Specifies whether a pod security policy should be enabled |
| podSecurityPolicy.name | string | `""` | The name of the pod security policy to use. If not set and create is true, a name is generated using the fullname template |
| postStartHook | object | `{}` | This hook is executed immediately after a container is created. However, there is no guarantee that the hook will execute before the container ENTRYPOINT. |
| preStopHook | object | `{}` | This hook is called immediately before a container is terminated due to an API request or management event such as liveness probe failure, preemption, resource contention and others. ref: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks |
| priority | int | `0` |  |
| priorityClassName | string | `""` | Overrides default priority class ref: https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| promtail.auditLog.scrape | bool | `false` |  |
| promtail.enabled | bool | `false` |  |
| promtail.extraScrapeConfigs | list | `[]` |  |
| promtail.lokiUrl | string | `"http://loki/loki/api/v1/push"` |  |
| promtail.pods.annotationPrefix | string | `"logging.kube-ops.io"` |  |
| promtail.pods.dropDebug | bool | `true` |  |
| promtail.pods.dropDeprecated | bool | `true` |  |
| promtail.pods.excludeNamespaces | list | `[]` |  |
| promtail.pods.extraPipelineStages | list | `[]` |  |
| promtail.pods.parseGolang | bool | `false` |  |
| promtail.pods.parseJava | bool | `false` |  |
| promtail.pods.parseKnownApps | bool | `false` |  |
| promtail.pods.parseLevels | bool | `false` |  |
| promtail.pods.parseNginxAccessLog | bool | `false` |  |
| promtail.pods.scrape | bool | `true` |  |
| promtail.syslog.listen | bool | `false` |  |
| promtail.systemJournal.scrape | bool | `false` |  |
| querier | object | `{"engine":{"maxLookBackPeriod":"30s","timeout":"3m"},"extraQueryDelay":"0s","queryIngestersWithin":"0s","queryTimeout":"1m","tailMaxDuration":"1h"}` | Configures the querier. Only appropriate when running all modules or just the querier. |
| querier.engine | object | `{"maxLookBackPeriod":"30s","timeout":"3m"}` | Configuration options for the LogQL engine. |
| querier.engine.maxLookBackPeriod | string | `"30s"` | The maximum amount of time to look back for log lines. Only applicable for instant log queries. |
| querier.engine.timeout | string | `"3m"` | Timeout for query execution |
| querier.extraQueryDelay | string | `"0s"` | Time to wait before sending more than the minimum successful query requests. |
| querier.queryIngestersWithin | string | `"0s"` | Maximum lookback beyond which queries are not sent to ingester. 0 means all queries are sent to ingester. |
| querier.queryTimeout | string | `"1m"` | Timeout when querying ingesters or storage during the execution of a query request. |
| querier.tailMaxDuration | string | `"1h"` | Maximum duration for which the live tailing requests should be served. |
| queryRange | object | `{}` | Configures the query splitting and caching in the Loki query-frontend. |
| rbac.annotations | object | `{}` |  |
| rbac.create | bool | `true` | Specifies whether a cluster role should be created |
| rbac.name | string | Generated using the fullname template | The name of the cluster role to use. |
| replicas | int | `1` | Replicas count |
| resources | object | `{}` |  |
| revisionHistoryLimit | int | `10` | specifies the number of old ReplicaSets to retain to allow rollback ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#revision-history-limit |
| ruler | object | `{}` | configures the Loki ruler. |
| runtimeClassName | string | `""` | Overrides default runtime class |
| runtimeConfig | object | `{"file":"","period":"10s"}` | Configuration for "runtime config" module, responsible for reloading runtime configuration file. |
| runtimeConfig.file | string | `""` | Configuration file to periodically check and reload. |
| runtimeConfig.period | string | `"10s"` | How often to check the file. |
| schedulerName | string | `""` | Overrides default scheduler |
| schemaConfig.configs[0] | object | `{"chunks":{"period":"168h","prefix":"","tags":{}},"from":"2020-11-01","index":{"period":"24h","prefix":"index_","tags":{}},"objectStore":"filesystem","rowShards":16,"schema":"v11","store":"boltdb"}` | The date of the first day that index buckets should be created. Use a date in the past if this is your only period_config, otherwise use a date when you want the schema to switch over. In YYYY-MM-DD format, for example: 2018-04-15. |
| schemaConfig.configs[0].chunks.period | string | `"168h"` | Table period. |
| schemaConfig.configs[0].chunks.prefix | string | `""` | Table prefix for all period tables. |
| schemaConfig.configs[0].chunks.tags | object | `{}` | A map to be added to all managed tables. |
| schemaConfig.configs[0].index.period | string | `"24h"` | Table period. |
| schemaConfig.configs[0].index.prefix | string | `"index_"` | Table prefix for all period tables. |
| schemaConfig.configs[0].index.tags | object | `{}` | A map to be added to all managed tables. |
| schemaConfig.configs[0].objectStore | string | `"filesystem"` | Which store to use for the chunks. Either aws, azure, gcp, bigtable, gcs, cassandra, swift or filesystem. If omitted, defaults to the same value as store. |
| schemaConfig.configs[0].rowShards | int | `16` | How many shards will be created. Only used if schema is v10 or greater. |
| schemaConfig.configs[0].schema | string | `"v11"` | The schema version to use, current recommended schema is v11. |
| schemaConfig.configs[0].store | string | `"boltdb"` | Which store to use for the index. Either aws, aws-dynamo, gcp, bigtable, bigtable-hashed, cassandra, boltdb-shipper or boltdb. |
| server.gracefulShutdownTimeout | string | `"30s"` | Timeout for graceful shutdowns |
| server.grpcMaxConcurrentStreams | int | `100` | Limit on the number of concurrent streams for gRPC calls (0 = unlimited) |
| server.grpcMaxRecvMsgSize | int | `4194304` | Max gRPC message size that can be received |
| server.grpcMaxSendMsgSize | int | `4194304` | Max gRPC message size that can be sent |
| server.grpcPort | int | `9095` | gRPC server listen port |
| server.httpIdleTimeout | string | `"120s"` | Idle timeout for HTTP server |
| server.httpPort | int | `3100` | HTTP server listen host |
| server.httpPrefix | string | `""` | Log only messages with the given severity or above. Supported values [debug, info, warn, error] -- Base path to serve all API routes from (e.g., /v1/). |
| server.httpReadTimeout | string | `"30s"` | Read timeout for HTTP server |
| server.httpWriteTimeout | string | `"30s"` | Write timeout for HTTP server |
| service.annotations | object | `{}` | Annotations for Service resource |
| service.clusterIP | string | `""` | Exposes the Service on a cluster IP ref: https://kubernetes.io/docs/concepts/services-networking/service/#choosing-your-own-ip-address |
| service.externalTrafficPolicy | string | `"Cluster"` | If you set service.spec.externalTrafficPolicy to the value Local, kube-proxy only proxies proxy requests to local endpoints, and does not forward traffic to other nodes. This approach preserves the original source IP address. If there are no local endpoints, packets sent to the node are dropped, so you can rely on the correct source-ip in any packet processing rules you might apply a packet that make it through to the endpoint. ref: https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-type-nodeport |
| service.grpcNodePort | int | `30095` |  |
| service.grpcPort | int | `9095` | gRPC port number |
| service.httpNodePort | int | `30080` | HTTP node port number (service.type==NodePort) -- gRPC node port number (service.type==NodePort) |
| service.httpPort | int | `80` | HTTP port number |
| service.labels | object | `{}` | Additional labels for Service resource |
| service.loadBalancerIP | string | `""` | Only applies to Service Type: LoadBalancer LoadBalancer will get created with the IP specified in this field. |
| service.loadBalancerSourceRanges | list | `[]` | If specified and supported by the platform, this will restrict traffic through the cloud-provider load-balancer will be restricted to the specified client IPs. ref: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/ |
| service.topology | bool | `false` | enables a service to route traffic based upon the Node topology of the cluster ref: https://kubernetes.io/docs/concepts/services-networking/service-topology/#using-service-topology Kubernetes >= kubeVersion 1.18 |
| service.topologyKeys | list | `[]` | A preference-order list of topology keys which implementations of services should use to preferentially sort endpoints when accessing this Service, it can not be used at the same time as externalTrafficPolicy=Local ref: https://kubernetes.io/docs/concepts/services-networking/service-topology/#using-service-topology |
| service.type | string | `"ClusterIP"` | Kubernetes ServiceTypes allow you to specify what kind of Service you want ref: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.labels | object | `{}` | Labels to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor.annotations | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.honorLabels | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.jobLabel | string | `"app.kubernetes.io/instance"` |  |
| serviceMonitor.labels | object | `{}` |  |
| serviceMonitor.metricRelabelings | list | `[]` |  |
| serviceMonitor.namespace | string | `"monitoring"` |  |
| serviceMonitor.path | string | `"/metrics"` |  |
| serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| startupProbe | object | `{}` |  |
| storageConfig.aws | object | `{"accessKeyId":"","bucketnames":"","dynamodb":{"apiLimit":2,"chunkGangSize":10,"chunkGetMaxParallelism":32,"dynamodbUrl":"","metrics":{"ignoreThrottleBelow":1,"queueLengthQuery":"sum(avg_over_time(cortex_ingester_flush_queue_length{job=\"cortex/ingester\"}[2m]))","readErrorQuery":"sum(increase(cortex_dynamo_failures_total{operation=\"DynamoDB.QueryPages\",error=\"ProvisionedThroughputExceededException\"}[1m])) by (table) > 0","readUsageQuery":"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.QueryPages\"}[1h])) by (table) > 0","scaleUpFactor":1.3,"targetQueueLength":100000,"url":"","writeThrottleQuery":"sum(rate(cortex_dynamo_throttled_total{operation=\"DynamoDB.BatchWriteItem\"}[1m])) by (table) > 0","writeUsageQuery":"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.BatchWriteItem\"}[15m])) by (table) > 0"},"throttleLimit":10},"endpoint":"","httpConfig":{"idleConnTimeout":"1m30s","insecureSkipVerify":false,"responseHeaderTimeout":"0s"},"insecure":false,"region":"","s3":"","s3forcepathstyle":false,"secretAccessKey":"","sseEncryption":false}` | Configures storing chunks in AWS. Required options only required when aws is present. |
| storageConfig.aws.accessKeyId | string | `""` | AWS Access Key ID. |
| storageConfig.aws.bucketnames | string | `""` | Comma separated list of bucket names to evenly distribute chunks over. Overrides any buckets specified in s3.url flag |
| storageConfig.aws.dynamodb | object | `{"apiLimit":2,"chunkGangSize":10,"chunkGetMaxParallelism":32,"dynamodbUrl":"","metrics":{"ignoreThrottleBelow":1,"queueLengthQuery":"sum(avg_over_time(cortex_ingester_flush_queue_length{job=\"cortex/ingester\"}[2m]))","readErrorQuery":"sum(increase(cortex_dynamo_failures_total{operation=\"DynamoDB.QueryPages\",error=\"ProvisionedThroughputExceededException\"}[1m])) by (table) > 0","readUsageQuery":"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.QueryPages\"}[1h])) by (table) > 0","scaleUpFactor":1.3,"targetQueueLength":100000,"url":"","writeThrottleQuery":"sum(rate(cortex_dynamo_throttled_total{operation=\"DynamoDB.BatchWriteItem\"}[1m])) by (table) > 0","writeUsageQuery":"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.BatchWriteItem\"}[15m])) by (table) > 0"},"throttleLimit":10}` | Configure the DynamoDB connection |
| storageConfig.aws.dynamodb.apiLimit | float | `2` | DynamoDB table management requests per-second limit. |
| storageConfig.aws.dynamodb.chunkGangSize | int | `10` | Number of chunks to group together to parallelise fetches (0 to disable) |
| storageConfig.aws.dynamodb.chunkGetMaxParallelism | int | `32` | Max number of chunk get operations to start in parallel. |
| storageConfig.aws.dynamodb.dynamodbUrl | string | `""` | URL for DynamoDB with escaped Key and Secret encoded. If only region is specified as a host, the proper endpoint will be deduced. Use inmemory:///<bucket-name> to use a mock in-memory implementation. |
| storageConfig.aws.dynamodb.metrics | object | `{"ignoreThrottleBelow":1,"queueLengthQuery":"sum(avg_over_time(cortex_ingester_flush_queue_length{job=\"cortex/ingester\"}[2m]))","readErrorQuery":"sum(increase(cortex_dynamo_failures_total{operation=\"DynamoDB.QueryPages\",error=\"ProvisionedThroughputExceededException\"}[1m])) by (table) > 0","readUsageQuery":"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.QueryPages\"}[1h])) by (table) > 0","scaleUpFactor":1.3,"targetQueueLength":100000,"url":"","writeThrottleQuery":"sum(rate(cortex_dynamo_throttled_total{operation=\"DynamoDB.BatchWriteItem\"}[1m])) by (table) > 0","writeUsageQuery":"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.BatchWriteItem\"}[15m])) by (table) > 0"}` | Metrics-based autoscaling configuration. |
| storageConfig.aws.dynamodb.metrics.ignoreThrottleBelow | float | `1` | Ignore throttling below this level (rate per second) |
| storageConfig.aws.dynamodb.metrics.queueLengthQuery | string | `"sum(avg_over_time(cortex_ingester_flush_queue_length{job=\"cortex/ingester\"}[2m]))"` | Query to fetch ingester queue length |
| storageConfig.aws.dynamodb.metrics.readErrorQuery | string | `"sum(increase(cortex_dynamo_failures_total{operation=\"DynamoDB.QueryPages\",error=\"ProvisionedThroughputExceededException\"}[1m])) by (table) > 0"` | Query to fetch read errors per table |
| storageConfig.aws.dynamodb.metrics.readUsageQuery | string | `"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.QueryPages\"}[1h])) by (table) > 0"` | Query to fetch read capacity usage per table |
| storageConfig.aws.dynamodb.metrics.scaleUpFactor | float | `1.3` | Scale up capacity by this multiple |
| storageConfig.aws.dynamodb.metrics.targetQueueLength | int | `100000` | Queue length above which we will scale up capacity. |
| storageConfig.aws.dynamodb.metrics.url | string | `""` | Use metrics-based autoscaling via this Prometheus query URL. |
| storageConfig.aws.dynamodb.metrics.writeThrottleQuery | string | `"sum(rate(cortex_dynamo_throttled_total{operation=\"DynamoDB.BatchWriteItem\"}[1m])) by (table) > 0"` | Query to fetch throttle rates per table |
| storageConfig.aws.dynamodb.metrics.writeUsageQuery | string | `"sum(rate(cortex_dynamo_consumed_capacity_total{operation=\"DynamoDB.BatchWriteItem\"}[15m])) by (table) > 0"` | Query to fetch write capacity usage per table |
| storageConfig.aws.dynamodb.throttleLimit | float | `10` | DynamoDB rate cap to back off when throttled. |
| storageConfig.aws.endpoint | string | `""` | S3 Endpoint to connect to. |
| storageConfig.aws.httpConfig.idleConnTimeout | string | `"1m30s"` | The maximum amount of time an idle connection will be held open. |
| storageConfig.aws.httpConfig.insecureSkipVerify | bool | `false` | Set to false to skip verifying the certificate chain and hostname. |
| storageConfig.aws.httpConfig.responseHeaderTimeout | string | `"0s"` | If non-zero, specifies the amount of time to wait for a server's response headers after fully writing the request. |
| storageConfig.aws.insecure | bool | `false` | Disable https on S3 connection. |
| storageConfig.aws.region | string | `""` | AWS region to use. |
| storageConfig.aws.s3 | string | `""` | S3 or S3-compatible endpoint URL with escaped Key and Secret encoded. If only region is specified as a host, the proper endpoint will be deduced. Use inmemory:///<bucket-name> to use a mock in-memory implementation. |
| storageConfig.aws.s3forcepathstyle | bool | `false` | Set to true to force the request to use path-style addressing |
| storageConfig.aws.secretAccessKey | string | `""` | AWS Secret Access Key. |
| storageConfig.aws.sseEncryption | bool | `false` | Enable AES256 AWS Server Side Encryption. |
| storageConfig.bigtable | object | `{"grpcClientConfig":{"backoffConfig":{"maxPeriod":"10s","maxRetries":10,"minPeriod":"100ms"},"backoffOnRatelimits":false,"grpcCompression":"gzip","maxRecvMsgSize":104857600,"maxSendMsgSize":16777216,"rateLimit":0,"rateLimitBurst":0},"instance":"","project":""}` | Configures storing chunks in Bigtable. Required fields only required when bigtable is defined in config. |
| storageConfig.bigtable.grpcClientConfig | object | `{"backoffConfig":{"maxPeriod":"10s","maxRetries":10,"minPeriod":"100ms"},"backoffOnRatelimits":false,"grpcCompression":"gzip","maxRecvMsgSize":104857600,"maxSendMsgSize":16777216,"rateLimit":0,"rateLimitBurst":0}` | Configures the gRPC client used to connect to Bigtable. |
| storageConfig.bigtable.grpcClientConfig.backoffConfig | object | `{"maxPeriod":"10s","maxRetries":10,"minPeriod":"100ms"}` | Configures backoff when enabled. |
| storageConfig.bigtable.grpcClientConfig.backoffConfig.maxPeriod | string | `"10s"` | The maximum delay when backing off. |
| storageConfig.bigtable.grpcClientConfig.backoffConfig.maxRetries | int | `10` | Number of times to backoff and retry before failing. |
| storageConfig.bigtable.grpcClientConfig.backoffConfig.minPeriod | string | `"100ms"` | Minimum delay when backing off. |
| storageConfig.bigtable.grpcClientConfig.grpcCompression | string | `"gzip"` | Use compression when sending messages. Supported values are: 'gzip', 'snappy' and '' (disable compression). |
| storageConfig.bigtable.grpcClientConfig.maxRecvMsgSize | int | `104857600` | Enable backoff and retry when a rate limit is hit. |
| storageConfig.bigtable.grpcClientConfig.maxSendMsgSize | int | `16777216` | The maximum size in bytes the client can send. |
| storageConfig.bigtable.grpcClientConfig.rateLimit | int | `0` | Rate limit for gRPC client. 0 is disabled. |
| storageConfig.bigtable.grpcClientConfig.rateLimitBurst | int | `0` | Rate limit burst for gRPC client. |
| storageConfig.bigtable.instance | string | `""` | BigTable instance ID |
| storageConfig.bigtable.project | string | `""` | BigTable project ID |
| storageConfig.boltdb | object | `{"directory":"/data/loki/index"}` | Configures storing index in BoltDB. Required fields only required when boltdb is present in config. |
| storageConfig.boltdb.directory | string | `"/data/loki/index"` | Location of BoltDB index files. |
| storageConfig.boltdbShipper | object | `{}` |  |
| storageConfig.cassandra | object | `{"addresses":"","auth":false,"caPath":"","connectTimeout":"600ms","consistency":"QUORUM","disableInitialHostLookup":false,"hostVerification":true,"keyspace":"","password":"","port":9042,"replicationFactor":1,"ssl":false,"timeout":"600ms","username":""}` | Configures storing chunks and/or the index in Cassandra |
| storageConfig.cassandra.addresses | string | `""` | Comma-separated hostnames or IPs of Cassandra instances |
| storageConfig.cassandra.auth | bool | `false` | Enable password authentication when connecting to Cassandra. |
| storageConfig.cassandra.caPath | string | `""` | Path to certificate file to verify the peer when SSL is enabled. |
| storageConfig.cassandra.connectTimeout | string | `"600ms"` | Initial connection timeout during initial dial to server. |
| storageConfig.cassandra.consistency | string | `"QUORUM"` | Consistency level for Cassandra |
| storageConfig.cassandra.disableInitialHostLookup | bool | `false` | Instruct the Cassandra driver to not attempt to get host info from the system.peers table. |
| storageConfig.cassandra.hostVerification | bool | `true` | Require SSL certificate validation when SSL is enabled. |
| storageConfig.cassandra.keyspace | string | `""` | Keyspace to use in Cassandra |
| storageConfig.cassandra.password | string | `""` | Password for password authentication when auth is true. |
| storageConfig.cassandra.port | int | `9042` | Port that cassandra is running on |
| storageConfig.cassandra.replicationFactor | int | `1` | Replication factor to use in Cassandra. |
| storageConfig.cassandra.ssl | bool | `false` | Use SSL when connecting to Cassandra instances. |
| storageConfig.cassandra.timeout | string | `"600ms"` | Timeout when connecting to Cassandra. |
| storageConfig.cassandra.username | string | `""` | Username for password authentication when auth is true. |
| storageConfig.filesystem | object | `{"directory":"/data/loki/chunks"}` | Configures storing the chunks on the local filesystem. Required fields only required when filesystem is present in config. |
| storageConfig.filesystem.directory | string | `"/data/loki/chunks"` | Directory to store chunks in. |
| storageConfig.gcs | object | `{"bucketName":"","chunkBufferSize":0,"requestTimeout":"0s"}` | Configures storing index in GCS. Required fields only required when gcs is defined in config. |
| storageConfig.gcs.bucketName | string | `""` | Name of GCS bucket to put chunks in. |
| storageConfig.gcs.chunkBufferSize | int | `0` | The size of the buffer that the GCS client uses for each PUT request. 0 to disable buffering. |
| storageConfig.gcs.requestTimeout | string | `"0s"` | The duration after which the requests to GCS should be timed out. |
| storageConfig.indexCacheValidity | string | `"5m"` | Cache validity for active index entries. Should be no higher than the chunk_idle_period in the ingester settings. |
| storageConfig.indexQueriesCacheConfig | object | `{"background":{"writebackBuffer":10000,"writebackGoroutines":10},"defaultValidity":"1h","enableFifocache":false,"fifocache":{"maxSizeBytes":"","maxSizeItems":0,"validity":"0s"},"memcached":{"batchSize":262144,"expiration":"1h","parallelism":100},"memcachedClient":{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"},"redis":{"db":1,"endpoint":"","expiration":"0s","idleTimeout":"0s","masterName":"","maxConnectionAge":"0s","password":"","poolSize":0,"timeout":"100ms"}}` | Config for how the cache for index queries should be built. |
| storageConfig.indexQueriesCacheConfig.background | object | `{"writebackBuffer":10000,"writebackGoroutines":10}` | Configures the background cache when memcached is used. |
| storageConfig.indexQueriesCacheConfig.background.writebackBuffer | int | `10000` | How many chunks to buffer for background write back to memcached. |
| storageConfig.indexQueriesCacheConfig.background.writebackGoroutines | int | `10` | How many goroutines to use to write back to memcached. |
| storageConfig.indexQueriesCacheConfig.defaultValidity | string | `"1h"` | The default validity of entries for caches unless overridden. |
| storageConfig.indexQueriesCacheConfig.enableFifocache | bool | `false` | Enable in-memory cache. |
| storageConfig.indexQueriesCacheConfig.fifocache.maxSizeBytes | string | `""` | Maximum number of entries in the cache. |
| storageConfig.indexQueriesCacheConfig.memcached | object | `{"batchSize":262144,"expiration":"1h","parallelism":100}` | Configures memcached settings. |
| storageConfig.indexQueriesCacheConfig.memcached.batchSize | int | `262144` | Configures how many keys to fetch in each batch request. |
| storageConfig.indexQueriesCacheConfig.memcached.expiration | string | `"1h"` | Configures how long keys stay in memcached. |
| storageConfig.indexQueriesCacheConfig.memcached.parallelism | int | `100` | Maximum active requests to memcached. |
| storageConfig.indexQueriesCacheConfig.memcachedClient | object | `{"consistentHash":true,"host":"","maxIdleConns":100,"service":"memcached","timeout":"100ms","updateInterval":"1m"}` | Configures how to connect to one or more memcached servers. |
| storageConfig.indexQueriesCacheConfig.memcachedClient.consistentHash | bool | `true` | Whether or not to use a consistent hash to discover multiple memcached servers. |
| storageConfig.indexQueriesCacheConfig.memcachedClient.host | string | `""` | The hostname to use for memcached services when caching chunks. If empty, no memcached will be used. A SRV lookup will be used. |
| storageConfig.indexQueriesCacheConfig.memcachedClient.maxIdleConns | int | `100` | The maximum number of idle connections in the memcached client pool. |
| storageConfig.indexQueriesCacheConfig.memcachedClient.service | string | `"memcached"` | SRV service used to discover memcached servers. |
| storageConfig.indexQueriesCacheConfig.memcachedClient.timeout | string | `"100ms"` | Maximum time to wait before giving up on memcached requests. |
| storageConfig.indexQueriesCacheConfig.memcachedClient.updateInterval | string | `"1m"` | The period with which to poll the DNS for memcached servers. |
| storageConfig.indexQueriesCacheConfig.redis.db | int | `1` | Database index. |
| storageConfig.indexQueriesCacheConfig.redis.endpoint | string | `""` | Redis Server endpoint to use for caching. A comma-separated list of endpoints for Redis Cluster or Redis Sentinel. If empty, no redis will be used. |
| storageConfig.indexQueriesCacheConfig.redis.expiration | string | `"0s"` | How long keys stay in the redis. |
| storageConfig.indexQueriesCacheConfig.redis.idleTimeout | string | `"0s"` | Close connections after remaining idle for this duration. If the value is zero, then idle connections are not closed. |
| storageConfig.indexQueriesCacheConfig.redis.masterName | string | `""` | Redis Sentinel master name. An empty string for Redis Server or Redis Cluster. |
| storageConfig.indexQueriesCacheConfig.redis.maxConnectionAge | string | `"0s"` | Close connections older than this duration. If the value is zero, then the pool does not close connections based on age. |
| storageConfig.indexQueriesCacheConfig.redis.password | string | `""` | Password to use when connecting to redis. |
| storageConfig.indexQueriesCacheConfig.redis.poolSize | int | `0` | Maximum number of connections in the pool. |
| storageConfig.indexQueriesCacheConfig.redis.timeout | string | `"100ms"` | Maximum time to wait before giving up on redis requests. |
| storageConfig.maxChunkBatchSize | int | `50` | The maximum number of chunks to fetch per batch. |
| storageConfig.swift.authUrl | string | `""` | Openstack authentication URL. |
| storageConfig.swift.containerName | string | `"cortex"` | Name of the Swift container to put chunks in. |
| storageConfig.swift.domainId | string | `""` | Openstack user's domain id. |
| storageConfig.swift.domainName | string | `""` | Openstack user's domain name. |
| storageConfig.swift.password | string | `""` | Openstack api key. |
| storageConfig.swift.projectDomainId | string | `""` | Id of the project's domain (v3 auth only), only needed if it differs the from user domain. |
| storageConfig.swift.projectDomainName | string | `""` | Name of the project's domain (v3 auth only), only needed if it differs from the user domain. |
| storageConfig.swift.projectId | string | `""` | Openstack project id (v2,v3 auth only). |
| storageConfig.swift.projectName | string | `""` | Openstack project name (v2,v3 auth only). |
| storageConfig.swift.regionName | string | `""` | Openstack Region to use eg LON, ORD - default is use first region (v2,v3 auth only) |
| storageConfig.swift.userDomainId | string | `""` | Openstack user's domain id. |
| storageConfig.swift.userDomainName | string | `""` | Openstack user's domain name. |
| storageConfig.swift.userId | string | `""` | Openstack userid for the api. |
| storageConfig.swift.username | string | `""` | Openstack username for the api. |
| tableManager | object | `{"chunkTablesProvisioning":{"enableInactiveThroughputOnDemandMode":false,"enableOndemandThroughputMode":false,"inactiveReadScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveReadScaleLastn":0,"inactiveReadThroughput":300,"inactiveWriteScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveWriteScaleLastn":0,"inactiveWriteThroughput":1,"provisionedReadThroughput":300,"provisionedWriteThroughput":3000,"readScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"writeScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}},"creationGracePeriod":"10m","indexTablesProvisioning":{"enableInactiveThroughputOnDemandMode":false,"enableOndemandThroughputMode":false,"inactiveReadScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveReadScaleLastn":0,"inactiveReadThroughput":300,"inactiveWriteScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveWriteScaleLastn":0,"inactiveWriteThroughput":1,"provisionedReadThroughput":300,"provisionedWriteThroughput":3000,"readScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"writeScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}},"pollInterval":"2m","retentionDeletesEnabled":false,"retentionPeriod":"0s","throughputUpdatesDisabled":false}` | Configures the table manager for retention |
| tableManager.chunkTablesProvisioning | object | `{"enableInactiveThroughputOnDemandMode":false,"enableOndemandThroughputMode":false,"inactiveReadScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveReadScaleLastn":0,"inactiveReadThroughput":300,"inactiveWriteScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveWriteScaleLastn":0,"inactiveWriteThroughput":1,"provisionedReadThroughput":300,"provisionedWriteThroughput":3000,"readScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"writeScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}}` | Configures management of the chunk tables for DynamoDB. |
| tableManager.chunkTablesProvisioning.enableInactiveThroughputOnDemandMode | bool | `false` | Enables on-demand throughput provisioning for the storage provide, if supported. Applies only to tables which are not autoscaled. |
| tableManager.chunkTablesProvisioning.enableOndemandThroughputMode | bool | `false` | Enables on-demand throughput provisioning for the storage provider, if supported. Applies only to tables which are not autoscaled. |
| tableManager.chunkTablesProvisioning.inactiveReadScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Inactive table read autoscale config. |
| tableManager.chunkTablesProvisioning.inactiveReadScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.chunkTablesProvisioning.inactiveReadScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.chunkTablesProvisioning.inactiveReadScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.chunkTablesProvisioning.inactiveReadScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.chunkTablesProvisioning.inactiveReadScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.chunkTablesProvisioning.inactiveReadScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.chunkTablesProvisioning.inactiveReadScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.chunkTablesProvisioning.inactiveReadScaleLastn | int | `0` | Number of last inactive tables to enable read autoscale. |
| tableManager.chunkTablesProvisioning.inactiveReadThroughput | int | `300` | DynamoDB table read throughput for inactive tables. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Inactive table write autoscale config. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.chunkTablesProvisioning.inactiveWriteScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.chunkTablesProvisioning.inactiveWriteScaleLastn | int | `0` | Number of last inactive tables to enable write autoscale. |
| tableManager.chunkTablesProvisioning.inactiveWriteThroughput | int | `1` | DynamoDB table write throughput for inactive tables. |
| tableManager.chunkTablesProvisioning.provisionedReadThroughput | int | `300` | DynamoDB table default read throughput. |
| tableManager.chunkTablesProvisioning.provisionedWriteThroughput | int | `3000` | DynamoDB table default write throughput. |
| tableManager.chunkTablesProvisioning.readScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Active table read autoscale config. |
| tableManager.chunkTablesProvisioning.readScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.chunkTablesProvisioning.readScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.chunkTablesProvisioning.readScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.chunkTablesProvisioning.readScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.chunkTablesProvisioning.readScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.chunkTablesProvisioning.readScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.chunkTablesProvisioning.readScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.chunkTablesProvisioning.writeScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Active table write autoscale config. |
| tableManager.chunkTablesProvisioning.writeScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.chunkTablesProvisioning.writeScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.chunkTablesProvisioning.writeScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.chunkTablesProvisioning.writeScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.chunkTablesProvisioning.writeScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.chunkTablesProvisioning.writeScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.chunkTablesProvisioning.writeScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.creationGracePeriod | string | `"10m"` | Duration a table will be created before it is needed. |
| tableManager.indexTablesProvisioning | object | `{"enableInactiveThroughputOnDemandMode":false,"enableOndemandThroughputMode":false,"inactiveReadScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveReadScaleLastn":0,"inactiveReadThroughput":300,"inactiveWriteScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"inactiveWriteScaleLastn":0,"inactiveWriteThroughput":1,"provisionedReadThroughput":300,"provisionedWriteThroughput":3000,"readScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80},"writeScale":{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}}` | Configures management of the index tables for DynamoDB. |
| tableManager.indexTablesProvisioning.enableInactiveThroughputOnDemandMode | bool | `false` | Enables on-demand throughput provisioning for the storage provide, if supported. Applies only to tables which are not autoscaled. |
| tableManager.indexTablesProvisioning.enableOndemandThroughputMode | bool | `false` | Enables on-demand throughput provisioning for the storage provider, if supported. Applies only to tables which are not autoscaled. |
| tableManager.indexTablesProvisioning.inactiveReadScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Inactive table read autoscale config. |
| tableManager.indexTablesProvisioning.inactiveReadScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.indexTablesProvisioning.inactiveReadScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.indexTablesProvisioning.inactiveReadScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.indexTablesProvisioning.inactiveReadScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.indexTablesProvisioning.inactiveReadScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.indexTablesProvisioning.inactiveReadScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.indexTablesProvisioning.inactiveReadScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.indexTablesProvisioning.inactiveReadScaleLastn | int | `0` | Number of last inactive tables to enable read autoscale. |
| tableManager.indexTablesProvisioning.inactiveReadThroughput | int | `300` | DynamoDB table read throughput for inactive tables. |
| tableManager.indexTablesProvisioning.inactiveWriteScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Inactive table write autoscale config. |
| tableManager.indexTablesProvisioning.inactiveWriteScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.indexTablesProvisioning.inactiveWriteScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.indexTablesProvisioning.inactiveWriteScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.indexTablesProvisioning.inactiveWriteScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.indexTablesProvisioning.inactiveWriteScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.indexTablesProvisioning.inactiveWriteScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.indexTablesProvisioning.inactiveWriteScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.indexTablesProvisioning.inactiveWriteScaleLastn | int | `0` | Number of last inactive tables to enable write autoscale. |
| tableManager.indexTablesProvisioning.inactiveWriteThroughput | int | `1` | DynamoDB table write throughput for inactive tables. |
| tableManager.indexTablesProvisioning.provisionedReadThroughput | int | `300` | DynamoDB table default read throughput. |
| tableManager.indexTablesProvisioning.provisionedWriteThroughput | int | `3000` | DynamoDB table default write throughput. |
| tableManager.indexTablesProvisioning.readScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Active table read autoscale config. |
| tableManager.indexTablesProvisioning.readScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.indexTablesProvisioning.readScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.indexTablesProvisioning.readScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.indexTablesProvisioning.readScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.indexTablesProvisioning.readScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.indexTablesProvisioning.readScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.indexTablesProvisioning.readScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.indexTablesProvisioning.writeScale | object | `{"enabled":false,"inCooldown":1800,"maxCapacity":6000,"minCapacity":3000,"outCooldown":1800,"roleArn":"","target":80}` | Active table write autoscale config. |
| tableManager.indexTablesProvisioning.writeScale.enabled | bool | `false` | Whether or not autoscaling should be enabled. |
| tableManager.indexTablesProvisioning.writeScale.inCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale down. |
| tableManager.indexTablesProvisioning.writeScale.maxCapacity | int | `6000` | DynamoDB maximum provision capacity. |
| tableManager.indexTablesProvisioning.writeScale.minCapacity | int | `3000` | DynamoDB minimum provision capacity. |
| tableManager.indexTablesProvisioning.writeScale.outCooldown | int | `1800` | DynamoDB minimum seconds between each autoscale up. |
| tableManager.indexTablesProvisioning.writeScale.roleArn | string | `""` | AWS AutoScaling role ARN. |
| tableManager.indexTablesProvisioning.writeScale.target | float | `80` | DynamoDB target ratio of consumed capacity to provisioned capacity. |
| tableManager.pollInterval | string | `"2m"` | Period with which the table manager will poll for tables. |
| tableManager.retentionDeletesEnabled | bool | `false` | Master 'on-switch' for table retention deletions. |
| tableManager.retentionPeriod | string | `"0s"` | How far back tables will be kept before they are deleted. 0s disables deletion. The retention period must be a multiple of the index / chunks table "period" (see periodConfig). |
| tableManager.throughputUpdatesDisabled | bool | `false` | Master 'off-switch' for table capacity updates, e.g. when troubleshooting. |
| target | string | `"all"` | The module to run Loki with. Supported values all, distributor, ingester, querier, query-frontend, table-manager. |
| terminationGracePeriodSeconds | int | `4800` | Grace period before the Pod is allowed to be forcefully killed ref: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/ |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` | control how Pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains. ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ |
| tracing | object | `{"enabled":false,"jaegerAgentHost":"","jaegerAgentPort":6831,"jaegerServiceName":"","jaegerTags":""}` | Configuration for tracing |
| tracing.enabled | bool | `false` | Whether or not tracing should be enabled. |
| updateStrategy.type | string | `"RollingUpdate"` | Specifies the strategy used to replace old Pods by new ones updateStrategy.rollingUpdate.partition -- If a partition is specified, all Pods with an ordinal that is greater than or equal to the partition will be updated when the StatefulSet's .spec.template is updated (updateStrategy.type==RollingUpdate) |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.kube-ops.io | generate | ~0.2.3 |
| https://charts.kube-ops.io | promtail | ~1.5.1 |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
