# t7-homelab

## Scope & Usage

This repository contains my personal IaC and automation configuration.
**It’s designed for my own infrastructure and will not work out-of-the-box for other environments**.
Feel free to reference the structure or scripts, but expect to customize heavily. 
It manages the deployment, configuration, and lifecycle of a self-hosted homelab environment using modern DevOps tools and best practices.

## Key Technologies Used

- **Terraform**: Infrastructure provisioning for VMs and cloud resources (Proxmox, GCP).
- **Ansible**: Configuration management and application deployment on provisioned hosts.
- **Docker**: Containerized services (e.g., Zabbix, Pi-hole, GitHub Runner).
- **Kubernetes**: Full on premises installation - environment for GitHub Actions runners deployment and more.
- **NGINX**: Reverse proxy for internal services and web server.
- **GitHub Actions**: CI/CD workflows for automated provisioning and configuration.
- **GCP (Google Cloud Platform)**: Remote state storage and optional cloud resources.
- **Proxmox**: On-premises virtualization platform for VM management (two nodes and third corosync device to ensure quorum).
- **Kaniko**: Container image builds without a Docker daemon, used in [gh-runner](https://github.com/AdrianT7/gh-runner) for building GitHub Actions runner images.
- **Helm**: Kubernetes package manager for deploying and managing applications using charts, simplifying repeatable installations (e.g., GitHub Actions runners, monitoring tools).


## Other technologies and deployments

- **pihole/**: Network-wide ad-blocking with Pi-hole.
- **zabbix_server/**: Monitoring with Zabbix.
- **k8s-dashboard/**: Dashboard for k8s management.
- **gcp_storage/**, **gcp_tf_backend/**: GCP buckets for storage and Terraform state.
- **bind9**: Authoritative DNS server.

## Repository Structure

```
.
├── ansible/                # Ansible roles for service configuration (nginx, docker, zabbix, etc.)
├── docker/                 # Docker VM environments (Terraform & Ansible)
├── gcp_storage/            # GCP storage bucket provisioning (Terraform)
├── gcp_tf_backend/         # GCP backend for Terraform state (Terraform)
├── github_runner/          # GitHub Actions self-hosted runner setup (Terraform & Ansible)
├── helm/                   # Helm charts directory
├── k8s/                    # Kubernetes cluster and runners deployment (Terraform & manifests)
├── nginx/                  # NGINX VM and configuration (Terraform & Ansible)
├── pihole/                 # Pi-hole deployment (Terraform & Ansible)
├── proxmox/                # Proxmox node configuration (Ansible)
├── t7-dns/                 # DNS VM deployment (Terraform & Ansible)
├── terraform/              # Shared Terraform modules (e.g., Proxmox VM)
├── zabbix_server/          # Zabbix server deployment (Terraform & Ansible)
├── .github/workflows/      # GitHub Actions CI/CD workflows
├── LICENSE                 # MIT License
├── renovate.json           # Renovate configuration for dependency updates
└── .gitignore              # Git ignore rules
```

## Key Features

- **Modular Infrastructure**: Uses reusable Terraform modules for VM provisioning on Proxmox and GCP.
- **Automated Configuration**: Ansible roles automate the setup of Docker, NGINX, Zabbix, Pi-hole, and more.
- **CI/CD Pipelines**: GitHub Actions workflows for both Terraform and Ansible, including plan/apply approval steps.
- **Secrets Management**: Sensitive data is injected via GitHub Actions secrets.
- **Reverse Proxy**: NGINX is configured as a reverse proxy for internal services (Zabbix, Pi-hole, Kubernetes Dashboard, etc.).
- **Self-hosted Runners**: Automated deployment of GitHub Actions runners on both Docker VMs and Kubernetes.
- **Remote State**: Terraform state is stored securely in GCP buckets.

## Notes

- Almost all infrastructure is managed as code and changes are reviewed via GitHub Actions.
- Sensitive files and Terraform state are excluded from version control.
- See each subdirectory for more detailed configuration and environment-specific files.

## Related Projects

- **gh-runner** ([GitHub](https://github.com/AdrianT7/gh-runner))  
  This repo builds GitHub Actions self-hosted runner images using **Kaniko**.  
  Docker images of my runners are available on [Docker Hub](https://hub.docker.com/repository/docker/adriant7/gh-runner/) for use in your own infrastructure.

- **helm-charts** 
  ([Helm repository](https://adriant7.github.io/helm-charts/index.yaml))
  ([GitHub repository](https://github.com/AdrianT7/helm-charts))
  Public repository hosting Helm charts for multiple projects, including `gh-runner`

## License

MIT License. See [LICENSE](LICENSE) for details.