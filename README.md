# Homelab Infrastructure

## Overview

Personal homelab built on HP Z2 mini workstations running Proxmox VE with k3s Kubernetes for DevOps learning and gaming. This repository contains all Infrastructure as Code, documentation, and automation scripts to rebuild the entire environment from scratch.

## Architecture

- **Physical**: 2x HP Z2 Mini Workstations (Z2G5: 64GB RAM + NVIDIA GPU, Z2G3: 32GB RAM)
- **Virtualization**: Proxmox VE 9.x cluster with NFS shared storage
- **Container Platform**: k3s Kubernetes cluster (1 master + 3 workers)
- **Automation**: Terraform + Ansible for complete Infrastructure as Code
- **Gaming**: GPU passthrough VM for low-latency gaming (Apex Legends, etc.)

## Quick Start

```bash
# Clone repository
git clone https://github.com/NuxD/homelab.git
cd homelab

# Deploy entire infrastructure
./scripts/bootstrap.sh

# Or deploy components individually
cd terraform && terraform apply
cd ../ansible && ansible-playbook -i inventories/production site.yml
```

## Project Status

### ✅ Completed
- [x] Physical hardware setup with BIOS configuration
- [x] Proxmox VE cluster installation and configuration
- [x] NFS shared storage between nodes
- [ ] Repository structure and documentation

### 🚧 Planned
- [ ] Network bridges and VLAN configuration
- [ ] Terraform automation for VM provisioning
- [ ] Ansible playbooks for k3s deployment
- [ ] Gaming VM with GPU passthrough configuration
- [ ] k3s cluster with monitoring stack (Prometheus/Grafana)
- [ ] CI/CD pipeline (GitLab CE)
- [ ] Backup and disaster recovery automation


## Hardware Specifications

| Component | HP Z2 G5 | HP Z2 G3 |
|-----------|----------|----------|
| **CPU** | Intel (VT-x/VT-d enabled) | Intel (VT-x/VT-d enabled) |
| **RAM** | 64GB DDR4 | 32GB DDR4 |
| **Storage** | NVMe SSD | NVMe SSD |
| **GPU** | NVIDIA (passthrough ready) | Integrated Graphics |
| **Network** | Gigabit Ethernet | Gigabit Ethernet |
| **Role** | Gaming + k3s master/worker | k3s workers + utilities |

## Network Layout

| Network | CIDR | Purpose |
|---------|------|---------|
| **LAN** | 192.168.40.0/24 | Main network, VM connectivity |
| **Pod Network** | 10.42.0.0/16 | Kubernetes pod communication (Flannel) |
| **Service Network** | 10.43.0.0/16 | Kubernetes services (ClusterIP) |
| **LoadBalancer Pool** | 192.168.40.150-160 | MetalLB external service IPs |
| **Cluster Bridge** | 10.0.100.0/24 | Inter-VM communication |

### IP Address Allocation

| Host/VM | IP Address | Purpose |
|---------|------------|---------|
| pve-z2g5 | 192.168.40.13 | Proxmox host + NFS server |
| pve-z2g3 | 192.168.40.12 | Proxmox host |
| k3s-master-01 | 192.168.40.100 | Kubernetes control plane |
| k3s-worker-01 | 192.168.40.101 | Kubernetes worker node |
| k3s-worker-02 | 192.168.40.102 | Kubernetes worker node |
| k3s-worker-03 | 192.168.40.103 | Kubernetes worker node |
| utility-vm | 192.168.40.110 | Monitoring and tools |


## Virtual Machine Layout

### Resource Allocation

**Z2G5 Node (64GB RAM total):**
- Gaming VM: 16GB RAM, 8 CPU cores, GPU passthrough
- k3s-master-01: 4GB RAM, 2 CPU cores
- k3s-worker-01: 4GB RAM, 2 CPU cores
- Host overhead: ~4GB
- **Available: 36GB RAM**

**Z2G3 Node (32GB RAM total):**
- k3s-worker-02: 4GB RAM, 2 CPU cores
- k3s-worker-03: 4GB RAM, 2 CPU cores
- utility-vm: 4GB RAM, 2 CPU cores
- Host overhead: ~4GB
- **Available: 16GB RAM**

## Learning Objectives

This homelab is designed to provide hands-on experience with:

### Infrastructure & Virtualization
- Type 1 hypervisor management (Proxmox VE)
- GPU passthrough for gaming workloads
- Shared storage with NFS
- Network virtualization and VLANs

### Kubernetes & Container Orchestration
- k3s lightweight Kubernetes distribution
- Pod networking with Flannel
- Service discovery and load balancing
- Persistent storage management
- Ingress controllers (Traefik)

### DevOps & Automation
- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- CI/CD pipelines (GitLab CE)
- Container registries and image security
- Monitoring and observability

### Site Reliability Engineering
- High availability patterns
- Backup and disaster recovery
- Performance monitoring and alerting
- Log aggregation and analysis

## Repository Structure

```
homelab/
├── README.md                    # This file
├── docs/                        # Documentation
│   ├── architecture/            # Architecture diagrams and decisions
│   ├── setup-guides/           # Step-by-step setup instructions
│   ├── troubleshooting/        # Common issues and solutions
│   └── learning-notes/         # Study notes and references
├── terraform/                  # Infrastructure as Code
│   ├── proxmox/               # Proxmox provider configuration
│   ├── modules/               # Reusable Terraform modules
│   └── environments/          # Environment-specific configs
├── ansible/                   # Configuration Management
│   ├── inventories/          # Host and group definitions
│   ├── playbooks/           # Automation playbooks
│   ├── roles/               # Reusable roles
│   └── group_vars/          # Variable definitions
├── scripts/                  # Automation scripts
│   ├── bootstrap.sh         # Complete environment setup
│   ├── backup.sh           # Backup automation
│   └── destroy.sh          # Environment teardown
├── configs/                 # Configuration files
│   ├── proxmox/            # Proxmox configurations
│   ├── k3s/                # Kubernetes manifests
│   └── applications/       # Application configurations
├── monitoring/             # Monitoring and observability
│   ├── dashboards/        # Grafana dashboards
│   ├── alerts/           # AlertManager rules
│   └── exporters/        # Custom metric exporters
└── .github/              # GitHub workflows (if using GitHub)
    └── workflows/        # CI/CD automation
```

## Prerequisites

### Required Software (Local Machine)
- **Terraform** >= 1.6.0
- **Ansible** >= 2.15.0
- **kubectl** >= 1.28.0
- **Git** >= 2.40.0

### Required Access
- SSH access to both Proxmox nodes
- Proxmox web interface access
- Network connectivity to 192.168.40.0/24 subnet

## Getting Started

### 1. Initial Setup

```bash
# Clone and setup repository
git clone https://github.com/NuxD/homelab.git
cd homelab

# Install required tools (Ubuntu/Debian)
./scripts/install-tools.sh

# Configure environment
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
cp ansible/inventories/production.example ansible/inventories/production

# Edit configuration files with your specific details
```

### 2. Deploy Infrastructure

```bash
# Option 1: Full automated deployment
./scripts/bootstrap.sh

# Option 2: Step-by-step deployment
cd terraform
terraform init
terraform plan
terraform apply

cd ../ansible
ansible-playbook -i inventories/production site.yml
```

### 3. Verify Deployment

```bash
# Check Proxmox cluster
ssh root@pve-z2g5 "pvecm status"

# Check k3s cluster
kubectl get nodes
kubectl get pods --all-namespaces

# Access services
curl http://grafana.homelab.local
curl http://gitlab.homelab.local
```

## Disaster Recovery

### Backup Strategy
- **Proxmox**: VM configurations and snapshots
- **k3s**: etcd backups and persistent volume snapshots
- **Applications**: Database dumps and configuration exports
- **Infrastructure**: All code in Git with tagged releases

### Recovery Process
```bash
# Complete environment rebuild
./scripts/destroy.sh
./scripts/bootstrap.sh

# Restore from backup
./scripts/restore-backup.sh [backup-date]
```


## Security Considerations

- **SSH Keys**: Use key-based authentication, disable password auth
- **Network**: Firewall rules limit access to management interfaces
- **Secrets**: Ansible Vault for sensitive data, never commit secrets
- **Updates**: Regular security updates via automation
- **Monitoring**: Security event monitoring and alerting

## Learning Resources

### Documentation
- [Proxmox VE Documentation](https://pve.proxmox.com/wiki/Main_Page)
- [k3s Documentation](https://docs.k3s.io/)
- [Terraform Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)

### Courses & Tutorials
- [Proxmox Homelab Series](https://www.youtube.com/playlist?list=PLT98CRl2KxKHnlbYhtABg6cF50bYa8Ulo)


**Project Status**: 🚧 Active Development  
**Next Milestone**: k3s cluster deployment automation