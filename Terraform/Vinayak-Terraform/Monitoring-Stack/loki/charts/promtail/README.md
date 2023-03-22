# promtail

[![Version: 1.5.1](https://img.shields.io/badge/Version-1.5.1-informational?style=flat-square) ](#)
[](#)
[![AppVersion: 2.2.1](https://img.shields.io/badge/AppVersion-2.2.1-informational?style=flat-square) ](#)
[![Artifact Hub: kube-ops](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kube-ops&style=flat-square)](https://artifacthub.io/packages/helm/kube-ops/promtail)

Responsible for gathering logs and sending them to Loki

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add kube-ops https://charts.kube-ops.io
$ helm repo update
$ helm upgrade my-release kube-ops/promtail --install --namespace my-namespace --create-namespace --wait
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
| annotations | object | `{}` |  |
| auditLog.path | string | `"/var/log/audit/audit.log"` | Overrides default audit log path. Must be absolute path to log file or mask. Example: /var/log/audit/*.log |
| auditLog.pipelineStages | list | `[]` | Pipeline stages |
| auditLog.scrape | bool | `false` | Specifies whether a audit log events should be collected |
| client.backoffConfig.maxPeriod | string | `"5m"` | Maximum backoff time between retries |
| client.backoffConfig.maxRetries | int | `10` | Maximum number of retries when sending batches, 0 means infinite retries |
| client.backoffConfig.minPeriod | string | `"500ms"` | Initial backoff time between retries |
| client.basicAuth.password | string | `""` | The password to use for basic auth |
| client.basicAuth.passwordFile | string | `""` | The file containing the password for basic auth |
| client.basicAuth.username | string | `""` | The username to use for basic auth |
| client.batchsize | int | `102400` | Maximum batch size (in bytes) of logs to accumulate before sending the batch to Loki. |
| client.batchwait | string | `"3s"` | Maximum amount of time to wait before sending a batch, even if that batch isn't full. |
| client.bearerToken | string | `""` | Bearer token to send to the server. |
| client.bearerTokenFile | string | `""` | File containing bearer token to send to the server. |
| client.insecureSkipVerify | bool | `false` | If true, ignores the server certificate being signed by an unknown CA. |
| client.proxyUrl | string | `""` | HTTP proxy server to use to connect to the server. |
| client.timeout | string | `"10s"` | Maximum time to wait for server to respond to a request |
| client.tls.caFile | string | `""` | The CA file to use to verify the server |
| client.tls.certFile | string | `""` | The cert file to send to the server for client auth |
| client.tls.keyFile | string | `""` | The key file to send to the server for client auth |
| client.tls.serverName | string | `""` | Validates that the server name in the server's certificate is this value. |
| criAutoconfigDebug | bool | `false` |  |
| criAutoconfigImage | string | `"quay.io/kube-ops/promtail-cri-autoconfig:1.0.1"` |  |
| dnsConfig | object | `{}` |  |
| dnsPolicy | string | `""` |  |
| ephemeralContainers | list | `[]` | Specifies ephemeral containers |
| extraArgs | list | `[]` | Additional CLI arguments for application |
| extraClientConfigs | list | `[]` | Additional client configs |
| extraContainers | list | `[]` | Specifies additional containers |
| extraEnvVars | list | `[]` | Additional environment variables |
| extraScrapeConfigs | list | `[]` | Custom scrape configs together with the default ones in the configmap |
| extraVolumeMounts | list | `[]` | Additional mounts for application |
| extraVolumes | list | `[]` | Additional volumes for application |
| fullnameOverride | string | `""` | Overrides the full name |
| global.imagePullPolicy | string | `"IfNotPresent"` | Image download policy |
| global.imagePullSecrets | list | `[]` | List of the Docker registry credentials |
| hostAliases | list | `[]` |  |
| image.repository | string | `"quay.io/kube-ops/promtail"` | Overrides the image repository |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| initContainers | list | `[]` |  |
| labels | object | `{}` |  |
| logLevel | string | `"error"` | Log only messages with the given severity or above. Supported values [debug, info, warn, error] |
| lokiUrl | string | `"http://loki/loki/api/v1/push"` |  |
| nameOverride | string | `""` | Overrides the chart name |
| networkPolicy.annotations | object | `{}` | Annotations for NetworkPolicy |
| networkPolicy.egress | list | `[{}]` | Egress rules |
| networkPolicy.enabled | bool | `false` | Specifies whether a NetworkPolicy should be created |
| networkPolicy.ingress | list | `[{}]` | Ingress rules |
| networkPolicy.labels | object | `{}` | Additional labels for NetworkPolicy |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` | Pod security settings |
| podSecurityPolicy.annotations | object | Seccomp annotations | Pod security policy annotations |
| podSecurityPolicy.create | bool | `true` | Specifies whether a pod security policy should be created |
| podSecurityPolicy.enabled | bool | `true` | Specifies whether a pod security policy should be enabled |
| podSecurityPolicy.name | string | Generated using the fullname template | The name of the pod security policy to use |
| pods.annotationPrefix | string | `"logging.kube-ops.io"` | All annotations with given prefix will be converted to labels. Example: log events from Pod annotated as `<prefix>/drop: "true"` will be labeled with `drop: true` |
| pods.containersDirectory | string | `"/var/lib/docker/containers"` |  |
| pods.cri | string | `"auto"` |  |
| pods.directory | string | `"/var/log/pods"` | Override default pods logs path |
| pods.dropDebug | bool | `true` |  |
| pods.dropDeprecated | bool | `true` |  |
| pods.dropLabel | bool | `true` |  |
| pods.dropLabels | list | `["controller-uid","controller-revision-hash","pod-template-hash","pod-template-generation","job-name","statefulset.kubernetes.io/pod-name","chart","heritage","app.kubernetes.io/managed-by","helm.sh/chart","addonmanager.kubernetes.io/mode","io.cilium/app","security.banzaicloud.io/mutate","gcp-auth-skip-secret","queue-pod-name"]` | All labels with this names will be dropped |
| pods.dropReadinessProbes | bool | `true` |  |
| pods.excludeNamespaces | list | `[]` | Exclude pods logs from given namespaces list |
| pods.extraPipelineStages | list | `[]` | Append custom pipeline stages |
| pods.nginxOutputTemplate | string | `"{{ if ne .user \"-\" }}{{ .user }}@{{ end }}{{ .ip }} {{ .method }} {{ .path }} {{ .size }} {{ if .referer }}{{ .referer }} {{ end }}| {{ .useragent }}\n"` |  |
| pods.parseGolang | bool | `true` |  |
| pods.parseJava | bool | `true` |  |
| pods.parseKnownApps | bool | `true` |  |
| pods.parseLevels | bool | `true` |  |
| pods.parseNginxAccessLog | bool | `true` |  |
| pods.pipelineStages | list | `[]` | Override default pipeline stages |
| pods.scrape | bool | `true` | Specifies whether a kubernetes pods logs should be collected |
| positionsPath | string | `"/run/promtail/positions.yaml"` |  |
| postStartHook | object | `{}` | This hook is executed immediately after a container is created. However, there is no guarantee that the hook will execute before the container ENTRYPOINT. |
| preStopHook | object | `{}` | This hook is called immediately before a container is terminated due to an API request or management event such as liveness probe failure, preemption, resource contention and others. ref: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks |
| priority | int | `0` |  |
| priorityClassName | string | `""` | Overrides default priority class ref: https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| rbac.annotations | object | `{}` |  |
| rbac.create | bool | `true` | Specifies whether a cluster role should be created |
| rbac.name | string | `""` | The name of the cluster role to use. If not set and create is true, a name is generated using the fullname template |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"64Mi"` |  |
| resources.requests.cpu | string | `"25m"` |  |
| resources.requests.memory | string | `"48Mi"` |  |
| revisionHistoryLimit | int | `10` | specifies the number of old ReplicaSets to retain to allow rollback ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#revision-history-limit |
| runtimeClassName | string | `""` | Overrides default runtime class |
| schedulerName | string | `""` | Overrides default scheduler |
| server.gracefulShutdownTimeout | string | `"30s"` | Timeout for graceful shutdowns |
| server.grpcListenAddress | string | `"0.0.0.0"` | gRPC server listen host |
| server.grpcMaxConcurrentStreams | int | `100` | Limit on the number of concurrent streams for gRPC calls (0 = unlimited) |
| server.grpcMaxRecvMsgSize | int | `4194304` | Max gRPC message size that can be received |
| server.grpcMaxSendMsgSize | int | `4194304` | Max gRPC message size that can be sent |
| server.grpcPort | int | `9095` | gRPC server listen port |
| server.healthCheckTarget | bool | `true` | Target managers check flag for promtail readiness, if set to false the check is ignored |
| server.httpIdleTimeout | string | `"120s"` | Idle timeout for HTTP server |
| server.httpPathPrefix | string | `""` | Base path to serve all API routes from (e.g., /v1/). |
| server.httpPort | int | `3101` | HTTP server listen host |
| server.httpReadTimeout | string | `"30s"` | Read timeout for HTTP server |
| server.httpWriteTimeout | string | `"30s"` | Write timeout for HTTP server |
| service.annotations | object | `{}` | Annotations for Service resource |
| service.clusterIP | string | `""` | Exposes the Service on a cluster IP See: https://kubernetes.io/docs/concepts/services-networking/service/#choosing-your-own-ip-address |
| service.externalTrafficPolicy | string | `"Cluster"` | If you set service.externalTrafficPolicy to the value Local, kube-proxy only proxies proxy requests to local endpoints, and does not forward traffic to other nodes. This approach preserves the original source IP address. If there are no local endpoints, packets sent to the node are dropped, so you can rely on the correct source-ip in any packet processing rules you might apply a packet that make it through to the endpoint. See: https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-type-nodeport |
| service.grpcNodePort | int | `30095` | gRPC node port number |
| service.grpcPort | int | `9095` | gRPC port number |
| service.httpNodePort | int | `30080` | HTTP node port number |
| service.httpPort | int | `80` | HTTP port number |
| service.labels | object | `{}` | Additional labels for Service resource |
| service.loadBalancerIP | string | `""` | Only applies to Service Type: LoadBalancer LoadBalancer will get created with the IP specified in this field. |
| service.loadBalancerSourceRanges | list | `[]` | If specified and supported by the platform, this will restrict traffic through the cloud-provider load-balancer will be restricted to the specified client IPs. ref: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/ |
| service.syslogNodePort | int | `31514` | Syslog node port number |
| service.syslogPort | int | `1514` | Syslog port number |
| service.topology | bool | `false` | enables a service to route traffic based upon the Node topology of the cluster ref: https://kubernetes.io/docs/concepts/services-networking/service-topology/#using-service-topology Kubernetes >= kubeVersion 1.18 |
| service.topologyKeys | list | `[]` | A preference-order list of topology keys which implementations of services should use to preferentially sort endpoints when accessing this Service, it can not be used at the same time as externalTrafficPolicy=Local ref: https://kubernetes.io/docs/concepts/services-networking/service-topology/#using-service-topology |
| service.type | string | `"ClusterIP"` | Specify what kind of Kubernetes Service you want. See: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.labels | object | `{}` | Labels to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor.annotations | object | `{}` |  |
| serviceMonitor.enabled | bool | `true` | Specifies whether a ServiceMonitor should be created (prometheus operator CRDs required) |
| serviceMonitor.honorLabels | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.jobLabel | string | `"app.kubernetes.io/instance"` |  |
| serviceMonitor.labels | object | `{}` |  |
| serviceMonitor.metricRelabelings | list | `[]` |  |
| serviceMonitor.namespace | string | `"monitoring"` |  |
| serviceMonitor.path | string | `"/metrics"` |  |
| serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| syslog.labels | object | `{}` |  |
| syslog.listen | bool | `false` |  |
| syslog.pipelineStages | list | `[]` |  |
| syslog.port | int | `1514` |  |
| systemJournal.directory | string | `"/var/log/journal"` | Override default journal path |
| systemJournal.json | bool | `false` | When true, log messages from the journal are passed through the pipeline as a JSON message with all of the journal entries' original fields. When false, the log message is the text content of the MESSAGE field from the journal entry. |
| systemJournal.maxAge | string | `"12h"` |  |
| systemJournal.pipelineStages | list | `[]` | Pipeline stages |
| systemJournal.scrape | bool | `false` | Specifies whether a systemd journal events should be collected |
| tenantId | string | `""` | The tenant ID used by default to push logs to Loki. If omitted or empty it assumes Loki is running in single-tenant mode and no X-Scope-OrgID header is sent. |
| terminationGracePeriodSeconds | int | `30` | Grace period before the Pod is allowed to be forcefully killed ref: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/ |
| tolerations[0].effect | string | `"NoSchedule"` |  |
| tolerations[0].operator | string | `"Exists"` |  |
| updateStrategy.type | string | `"RollingUpdate"` | Specifies the strategy used to replace old Pods by new ones |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.kube-ops.io | generate | ~0.2.2 |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
