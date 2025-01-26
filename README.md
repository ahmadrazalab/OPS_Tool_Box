# Welcome to the **DevOps Toolbox**

This repository is a comprehensive guide to deploying and configuring essential DevOps tools for logging, monitoring, and CI/CD workflows. Whether you're setting up Grafana, Kibana, Fluent Bit, Istio, ArgoCD, or other popular tools, each folder in this repository provides step-by-step instructions, best practices, and configuration files to simplify your deployment process.

> Ideal for DevOps engineers, SREs, and developers, this repository aims to be your go-to resource for building a reliable and scalable DevOps stack.

## Directory Structure

```bash
├── Dev
│   ├── Dev-Apps
│   │   ├── [app-log-ui-php-main](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/app-log-ui-php-main)
│   │   ├── [contact-page-api-lambda-lambda-deploy](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/contact-page-api-lambda-lambda-deploy)
│   │   ├── [contact-page-api-lambda-main](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/contact-page-api-lambda-main)
│   │   ├── [go-contact-api-lambda-main](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/go-contact-api-lambda-main)
│   │   ├── [K8-ping-Host.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/K8-ping-Host.md)
│   │   ├── [Kubernetes-seafile-share-main](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/Kubernetes-seafile-share-main)
│   │   ├── [mailpit-service-main](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/mailpit-service-main)
│   │   └── [smtp-test-app-ui-main](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Dev-Apps/smtp-test-app-ui-main)
│   ├── Homepage-WebDashboard
│   │   ├── [background-video.mp4](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Homepage-WebDashboard/background-video.mp4)
│   │   ├── [index.html](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Homepage-WebDashboard/index.html)
│   │   ├── [README.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Homepage-WebDashboard/README.md)
│   │   ├── [script.js](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Homepage-WebDashboard/script.js)
│   │   ├── [styles.css](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Homepage-WebDashboard/styles.css)
│   │   └── [video-page](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Homepage-WebDashboard/video-page)
│   └── Ubuntu-Server-UserData
│       ├── [other-config.sh](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Ubuntu-Server-UserData/other-config.sh)
│       ├── [README.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Ubuntu-Server-UserData/README.md)
│       ├── [ubuntu-desktop.sh](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Ubuntu-Server-UserData/ubuntu-desktop.sh)
│       └── [ubuntu-server.sh](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Dev/Ubuntu-Server-UserData/ubuntu-server.sh)
├── DevOPS-Tools
│   ├── ANSIBLE
│   │   ├── [intro.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/ANSIBLE/intro.md)
│   │   └── [Nginx-ansible-ubuntu.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/ANSIBLE/Nginx-ansible-ubuntu.md)
│   ├── CICD
│   │   ├── [github-CICD.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/CICD/github-CICD.mdx)
│   │   ├── [github-runner.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/CICD/github-runner.mdx)
│   │   ├── [gitlab-CICD.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/CICD/gitlab-CICD.mdx)
│   │   └── [gitlab-runner.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/CICD/gitlab-runner.mdx)
│   ├── Docker
│   │   ├── [D-compose.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Docker/D-compose.mdx)
│   │   ├── [D-Guide.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Docker/D-Guide.mdx)
│   │   └── [Dockerfile-Samples.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Docker/Dockerfile-Samples.mdx)
│   ├── efk-stack
│   │   ├── [EKS](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/efk-stack/EKS)
│   │   ├── [fluent-bit-s3-plugin.yaml](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/efk-stack/fluent-bit-s3-plugin.yaml)
│   │   ├── [helm.sh](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/efk-stack/helm.sh)
│   │   ├── [Kind](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/efk-stack/Kind)
│   │   └── [Minikube](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/efk-stack/Minikube)
│   ├── Gitlab
│   │   ├── [Self-Host.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Gitlab/Self-Host.mdx)
│   │   └── [upgrade.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Gitlab/upgrade.mdx)
│   ├── Grafana-Stack
│   │   ├── [Kubernetes-Ext-Olly](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Grafana-Stack/Kubernetes-Ext-Olly)
│   │   ├── [Minikube](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Grafana-Stack/Minikube)
│   │   └── [VM-Setup](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Grafana-Stack/VM-Setup)
│   ├── [Jenkins.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Jenkins.md)
│   ├── Kafka-Setup
│   │   ├── [Kafka-as-Docker](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/Kafka-as-Docker)
│   │   ├── [KAFKA-LoadTest.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/KAFKA-LoadTest.md)
│   │   ├── [Kafka-logging-apps](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/Kafka-logging-apps)
│   │   ├── [load-test.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/load-test.md)
│   │   ├── [nginx.conf](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/nginx.conf)
│   │   ├── [README.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/README.md)
│   │   ├── [run.sh](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/run.sh)
│   │   └── [Systemctl-KafkaZ.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Kafka-Setup/Systemctl-KafkaZ.md)
│   ├── SonarQube
│   │   ├── [cicd-integration.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/SonarQube/cicd-integration.mdx)
│   │   ├── [Docker-Setup.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/SonarQube/Docker-Setup.mdx)
│   │   └── [ec2-userdata.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/SonarQube/ec2-userdata.mdx)
│   └── Zabbix
│       ├── [install-agent.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Zabbix/install-agent.mdx)
│       └── [Server-Setup.mdx](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/DevOPS-Tools/Zabbix/Server-Setup.mdx)
├── Kubernetes
│   ├── [Argo-CD.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/Argo-CD.md)
│   ├── [Falco.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/Falco.md)
│   ├── [helm.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/helm.md)
│   ├── [Istio.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/Istio.md)
│   ├── [Jaeger.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/Jaeger.md)
│   ├── [k9s.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/k9s.md)
│   ├── [MetricAPI.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/MetricAPI.md)
│   └── [Trevy.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Kubernetes/Trevy.md)
├── Mini-Apps
│   ├── k8-log-generator
│   │   ├── [1-demo-loggers.yaml](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Mini-Apps/k8-log-generator/1-demo-loggers.yaml)
│   │   ├── [2-app-logger.yaml](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Mini-Apps/k8-log-generator/2-app-logger.yaml)
│   │   ├── [extreme-pod-logger.yaml](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Mini-Apps/k8-log-generator/extreme-pod-logger.yaml)
│   │   └── [setup.md](https://github.com/ahmadrazalab/OPS_Tool_Box/tree/main/Mini-Apps/k8-log-generator/setup.md)
│   ├── k8-node-stress
│   │   ├── Setup.md
│   │   └── stress-pod.yaml
│   └── Kubernetes-DB-Static
│       ├── db-static-pod-service.yaml
│       ├── db-static-pod.yaml
│       ├── docker-compose.yaml
│       ├── mysql-using-pv
│       └── README.md
└── README.md