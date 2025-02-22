# Project: Azure Fundamental Hands-on

This project is to gain hands-on experience about Microsoft Azure. 

## Gained knowledge
- Azure:
    - Fundamental RBAC, ODIC with GitHub Actions
    - VNet, subnets (public and private), NSG, Private DNS Zone
    - Load Balancer: health probe, backend pool, routing rules
    - Static website on Azure Container Storage
    - Bastion: Developer SKU (it's free!!!), Key Vault integration
    - Flexible Server for PostgreSQL: private VNet mode - delegated subnet

## Note
Most of the components in `architecture.png` are provisioned automatically via Terraform and GitHub Actions, there're still some missing components or manual operations required, such as:
- NSGs for subnets
- Cloudflare DNS records
- Dockerize backend application and deploy it on VMs
