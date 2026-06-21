# Calorie Lens Infrastructure

Terraform-based AWS infrastructure for Calorie Lens, delivering secure, scalable backend resources for asset storage and content delivery.

- Provisioned modular AWS infrastructure using Terraform, including encrypted S3 storage, CloudFront distribution with Origin Access Control, and SSM Parameter Store metadata management.
- Implemented a remote Terraform backend with S3 state storage and DynamoDB locking to ensure safe, reproducible deployments and team-ready state management.
- Designed reusable modules for storage, CDN, and secrets management, supporting environment-specific configuration via `*.tfvars` and secure profile-based AWS access.
- Optimized infrastructure for security and scalability with encryption, versioning, access controls, and a production-ready CDNI architecture.
