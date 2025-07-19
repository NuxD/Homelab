
# 🏠 Homelab Infrastructure (Single-Node – HP Z2 G5)

A personal homelab built on a single **HP Z2 Mini G5 workstation**, designed to explore and showcase best practices in **DevOps**, **Cloud**, and **Cybersecurity**.  
Fully automated with **Ansible**, running **Kubernetes via k3s** in virtual machines, with built-in **monitoring**, **logging**, and **secure remote access** via **Tailscale**.



## 🎯 Goals

- 🛠️ Infrastructure-as-Code (Ansible, Terraform)
- ☸️ Kubernetes + Docker container orchestration
- 📈 Monitoring, Logging, and Alerting
- 🔐 Secure remote access (Tailscale VPN, SSH, MFA)
- 🚀 GitOps workflows with ArgoCD
- 🔁 CI/CD pipelines and automation



## 🖥️ Hardware

- **1x HP Z2 Mini G5 Workstation**
  - 64 GB RAM
  - Ubuntu Server 22.04 LTS
  - SSD/NVMe storage
  - Wired gigabit network



## 🧱 Virtualization Layer

- **Libvirt** for VM management  
- GUI tools: **Virt-Manager** and **Cockpit** for VM lifecycle management  
- Networking configured to support k3s cluster VMs and allow Tailscale access across the virtual network  



## 🔐 Remote Access

- **Tailscale** provides secure zero-config VPN across your devices and VMs  
- SSH with hardened keys and optional MFA  
- Firewall rules via UFW + Fail2Ban protect host and guests  
- Tailscale enables seamless access to Kubernetes dashboards, Rancher UI, and other services  



## ☸️ Kubernetes Cluster (k3s)

A lightweight, production-grade Kubernetes distribution.

**VM Topology:**

| Role          | vCPUs | RAM  | Description                |
|---------------|-------|------|----------------------------|
| Control Plane | 2     | 4 GB | Cluster control / API      |
| Worker Node 1 | 2     | 4 GB | App workloads              |
| Worker Node 2 | 2     | 4 GB | App workloads              |



## 🗺️ Architecture Overview

```
┌────────────────────────────┐
│     HP Z2 G5 Workstation   │
│     Ubuntu Server 22.04    │
└────────────┬───────────────┘
             │
        [ Libvirt ]
             │
 ┌────┬──────────┬────────────┐
 │ CP │ Worker 1 │ Worker 2   │
 └────┴──────────┴────────────┘
             │
        [ k3s Cluster ]
             │
 ┌───────────▼────────────┐
 │  Rancher UI Dashboard  │
 │  Prometheus + Grafana  │
 │  Traefik / MetalLB     │
 └────────────────────────┘
             │
        [ Tailscale VPN ]
             │
      Remote Devices
```



## 📦 Features & Services

| Area            | Tools / Stack                       |
|-----------------|-----------------------------------|
| Monitoring      | Prometheus, Grafana                |
| Logging         | Loki, Fluent Bit                   |
| CI/CD           | GitHub Actions, ArgoCD             |
| GitOps          | ArgoCD or Flux                    |
| Kubernetes GUI  | Rancher UI, Kubernetes Dashboard  |
| Storage         | Local Path Provisioner, Longhorn  |
| Automation      | Ansible, Terraform (libvirt)      |



## 📁 Repository Structure

```
homelab/
├── ansible/               # Playbooks and roles
├── terraform/             # Optional: libvirt infrastructure as code
├── k8s/                   # Helm charts, manifests
│   ├── manifests/
│   └── helm-charts/
├── docs/                  # Diagrams, docs
│   └── architecture-diagram.png
└── README.md
```



## 🧪 Use Cases

- Deploy microservices with Helm and GitOps  
- Simulate production cluster locally  
- Practice Kubernetes security (RBAC, PSP, Network Policies)  
- Self-host DevOps tools (Jenkins, Gitea, etc.)  
- Build internal dashboards and metrics  
- Learn secure remote access and infrastructure hardening  



## 📍 Roadmap

- [ ] 🔧 Automate Libvirt VM provisioning with Ansible or Terraform  
- [ ] 🌐 Improve Tailscale access control and ACLs for service-level segmentation  
- [ ] ☸️ Expand k3s cluster with additional worker VMs for scaling/testing  
- [ ] 📦 Deploy GitOps tools like ArgoCD or Flux to manage manifests  
- [ ] 📊 Integrate full observability stack (Prometheus + Grafana + Loki)  
- [ ] 🔐 Add centralized secrets management (e.g., HashiCorp Vault or sealed-secrets)  
- [ ] 📁 Implement shared or replicated storage (Longhorn / NFS)  
- [ ] 💡 Self-host DevOps tools (e.g., Gitea, Jenkins, Drone CI) for pipeline practice  
- [ ] 🧪 Simulate real-world scenarios: failover, load testing, cluster upgrades  
- [ ] 🛡️ Apply Kubernetes security: RBAC, Network Policies, PodSecurity Standards  
- [ ] 📚 Document playbooks, VM definitions, and architecture for reproducibility  



## 🙌 Acknowledgements

- [k3s](https://k3s.io/)  
- [Rancher](https://rancher.com/)  
- [Libvirt](https://libvirt.org/)  
- [Tailscale](https://tailscale.com/)  
- [Ansible](https://www.ansible.com/)  
- [Grafana](https://grafana.com/)  
- [ArgoCD](https://argo-cd.readthedocs.io/)

