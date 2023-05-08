#!/bin/bash

export cluster_name=EKS-Upgrade
export region=us-east-1
export version=1.20
export profile=DevOps

echo " Cluster is Upgrading............ "
eksctl upgrade cluster --name=$cluster_name --region $region --profile $profile --approve

echo "Updating the kube-proxy.........."
if [[ "$version" == "1.19" ]]; then
    export proxy_version="v1.19.16-eksbuild.2"
elif [[ "$version" == "1.20" ]]; then
    export proxy_version="v1.20.15-eksbuild.2"
elif [[ "$version" == "1.21" ]]; then
    export proxy_version="v1.21.14-eksbuild.2"
elif [[ "$version" == "1.22" ]]; then
    export proxy_version="v1.22.11-eksbuild.2"
elif [[ "$version" == "1.23" ]]; then
    export proxy_version="v1.23.8-eksbuild.2"
elif [[ "$version" == "1.24" ]]; then
    export proxy_version="v1.24.7-eksbuild.1"
fi

kubectl set image daemonset.apps/kube-proxy -n kube-system kube-proxy=602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/kube-proxy:$proxy_version
eksctl utils update-kube-proxy --cluster=$cluster_name --region $region --profile DevOps --approve

echo "Updated kube-proxy version is:"
kubectl get daemonset kube-proxy --namespace kube-system -o=jsonpath='{$.spec.template.spec.containers[:1].image}'

echo "Updating the CoreDNS............."$'\n'
eksctl utils update-coredns --cluster=$cluster_name --region $region --profile $profile --approve

echo "updated coredns version is:"
kubectl describe deployment coredns --namespace kube-system | grep Image | cut -d "/" -f 3

# # kubectl scale deployments/cluster-autoscaler --replicas=0 -n kube-system
echo "Updating the NodeGroup............."
eksctl upgrade nodegroup --name=Spot-1 --cluster=$cluster_name --kubernetes-version=$version --region $region --profile $profile 

