# Welcome to the **DevOps Toolbox** (or **OpsLab Playbook**, depending on your chosen name)! 

This repository is a comprehensive guide to deploying and configuring essential DevOps tools for logging, monitoring, and CI/CD workflows. 
Whether you're setting up Grafana, Kibana, Fluent Bit, Istio, ArgoCD, or other popular tools, each folder in this repository provides step-by-step instructions, best practices, and configuration files to simplify your deployment process.

> Ideal for DevOps engineers, SREs, and developers, this repository aims to be your go-to resource for building a reliable and scalable DevOps stack.


# Directory structure
├── Apps
│   ├── k8-log-generator
│   │   ├── 1-demo-loggers.yaml
│   │   ├── 2-app-logger.yaml
│   │   ├── extreme-pod-logger.yaml
│   │   └── setup.md
│   ├── k8-node-stress
│   │   ├── Setup.md
│   │   └── stress-pod.yaml
│   └── lambda
│       ├── Event-lambda-execution.md
│       ├── Lambda-for-RDS.md
│       └── LambdaMgmt-Layerd.md
├── DevOPS-Tools
│   ├── ANSIBLE
│   │   ├── intro.md
│   │   └── Nginx-ansible-ubuntu.md
│   ├── Argo-CD.md
│   ├── efk-stack
│   │   ├── AKS
│   │   ├── EKS
│   │   │   └── READ-elastic-fluentd-s3.md
│   │   ├── fluent-bit-s3-plugin.yaml
│   │   ├── helm.sh
│   │   ├── Kind
│   │   │   └── cluster-0.yaml
│   │   └── Minikube
│   │       ├── DO-efk-7.2.0-FULL.yaml
│   │       ├── DO-efk-7.2.0-noPV.yaml
│   ├── Grafana-Stack
│   │   ├── AKS+PV
│   │   ├── EKS+PV
│   │   ├── Minikube
│   │   │   ├── k8s-grafana-loki.md
│   │   │   ├── k8s-grafana-prometheus-beta.md
│   │   │   └── k8s-grafana-prometheus.md
│   │   └── VM-Setup
│   │       ├── Grafana-full-Stack
│   │       │   ├── Logging.md
│   │       │   └── Monitoring.md
│   │       └── prometheus+alerts
│   │           ├── alert-m.yml
│   │           ├── alert-rule-prom.yaml
│   │           ├── alert-rules-pro.yaml
│   │           ├── group-byalerts.yaml
│   │           ├── labels.md
│   │           ├── prom.yml
│   │           ├── services.sh
│   │           └── wget-nodexport.sh
│   ├── helm.md
│   ├── istio
│   ├── Jenkins.md
│   ├── k9s.md
│   ├── Kafka-Setup
│   │   ├── Kafka-as-Docker
│   │   │   └── docker-compose.yaml
│   │   ├── KAFKA-LoadTest.md
│   │   ├── Kafka-logging-apps
│   │   │   ├── kafka-consumer.py
│   │   │   └── kafka-logger.py
│   │   ├── load-test.md
│   │   ├── nginx.conf
│   │   ├── README.md
│   │   ├── run.sh
│   │   └── Systemctl-KafkaZ.md
│   └── Trevy.md
└── README.md