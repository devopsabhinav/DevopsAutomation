#!/bin/sh

# Author : Vinayak Pawar
# Monitoring-stack automation Script

read -p "Enter Namespace: " namespace
read -p "Loki Release_Name: " loki_name
read -p "kps Release_Name: " kps_name

# Install Loki

helm upgrade --install $loki_name loki -n monitoring

# Install kube-prometheus-stack

helm upgrade --install $kps_name kube-prometheus-stack -n monitoring