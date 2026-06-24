# Calorie Lens Infrastructure

Terraform-based AWS infrastructure for the Calorie Lens project.

## What the project does

This repository defines reusable AWS infrastructure using Terraform.

- `bootstrap/` provisions Terraform backend state resources: an S3 bucket for remote state and a DynamoDB table for Terraform state locking.
- `modules/storage/` creates an encrypted, versioned S3 bucket with lifecycle rules and a CloudFront access policy.
- `modules/cdn/` creates a CloudFront distribution with Origin Access Control (OAC) for secure S3 origin access.
- `modules/secrets/` stores configuration values in AWS Systems Manager Parameter Store.
- The root configuration wires these modules together and publishes infrastructure outputs.

## Why this project is useful

- Establishes production-ready AWS infrastructure for storage, CDN delivery, and secrets configuration.
- Keeps backend state provisioning separate from application infrastructure.
- Enforces AWS security best practices for S3 and CloudFront.
- Supports modular Terraform reuse across future infrastructure additions.

## Getting started

### Prerequisites

- Terraform installed
- AWS CLI configured with a working AWS profile
- AWS permissions for S3, DynamoDB, CloudFront, and SSM Parameter Store

### Bootstrap the Terraform backend

```bash
cd bootstrap
terraform init
terraform validate
terraform plan
terraform apply
```

This creates the backend state bucket and DynamoDB lock table used by the main configuration.

### Deploy the main infrastructure

From the repository root:

```bash
terraform init
terraform validate
terraform plan -var="aws_profile=<profile>" -var="project_name=<project>"
terraform apply -var="aws_profile=<profile>" -var="project_name=<project>"
```

### Required variables

- `aws_profile`: AWS CLI profile name
- `project_name`: Project name prefix for resources

## Project structure

- `bootstrap/` — backend state Terraform configuration
- `modules/storage/` — encrypted S3 bucket module
- `modules/cdn/` — CloudFront distribution module
- `modules/secrets/` — SSM Parameter Store module
- `main.tf`, `modules.tf`, `variables.tf` — root Terraform configuration and module wiring

## Where to get help

- Open an issue in this repository for questions or problems.
- Review `AGENTS.md` for project-specific agent guidance.

## Who maintains and contributes

Contributions are welcome.

- Use `terraform validate` and `terraform plan` before making changes.
- Preserve module boundaries and existing AWS provider conventions.
- Keep this repository infrastructure-only; do not add application code.

If you would like to contribute more formally, please open an issue first to discuss the proposed change.
