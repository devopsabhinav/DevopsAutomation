#!/bin/sh

# Author : Vinayak Pawar
# Istio automation Script

# Install Istioctl
 
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.16.0
export PATH=$PWD/bin:$PATH

# Install Istio

istioctl install --set profile=default  --set values.gateways.istio-ingressgateway.type=NodePort

read -p "Enter Namespace: " namespace
kubectl label namespace $namespace istio-injection=enabled
