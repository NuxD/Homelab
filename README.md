# Homelab Infrastructure

## Overview

Personal homelab built on HP Z2 mini workstations running Proxmox VE with k3s Kubernetes. This repository contains all Infrastructure as Code, documentation, and automation scripts to rebuild the entire environment from scratch.

## Architecture

- **Physical**: 2x HP Z2 Mini Workstations (Z2G5: 64GB RAM + NVIDIA GPU, Z2G3: 32GB RAM)
- **Virtualization**: Proxmox VE 9.x cluster with NFS shared storage
- **Container Platform**: k3s Kubernetes cluster (1 master + 3 workers)
- **Automation**: Terraform + Ansible for complete Infrastructure as Code

## Project Status

- [x] Physical hardware setup with BIOS configuration
- [x] Proxmox VE cluster installation and configuration
- [x] NFS shared storage between nodes
- [x] Terraform automation for VM provisioning
- [ ] Network bridges and VLAN configuration
- [ ] Ansible playbooks for k3s deployment
- [ ] k3s cluster with monitoring stack (Prometheus/Grafana)
- [ ] CI/CD pipeline (GitLab CE)
- [ ] Backup and disaster recovery automation


## Hardware Specifications

| Component | HP Z2 G5 | HP Z2 G3 |
|-----------|----------|----------|
| **CPU** | Intel (VT-x/VT-d enabled) | Intel (VT-x/VT-d enabled) |
| **RAM** | 64GB DDR4 | 32GB DDR4 |
| **Storage** | NVMe SSD | NVMe SSD |
| **Network** | Gigabit Ethernet | Gigabit Ethernet |
| **Role** | k3s master/worker | k3s workers + utilities |

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
- Service discovery and load balancing
- Persistent storage management
- Ingress controllers (Traefik)

### DevOps & Automation
- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- CI/CD pipelines
- Container registries and image security
- Monitoring and observability

### Site Reliability Engineering
- High availability patterns
- Backup and disaster recovery
- Performance monitoring and alerting
- Log aggregation and analysis

### Required Software (Local Machine)
- **Terraform** >= 3.0.2-rc04
- **Ansible** >= 2.15.0
- **kubectl** >= 1.28.0
- **Git** >= 2.40.0

### Required Access
- SSH access to both Proxmox nodes
- Proxmox web interface access
- Network connectivity to 192.168.40.0/24 subnet

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
