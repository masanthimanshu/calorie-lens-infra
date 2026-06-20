# Calorie Lens Infrastructure

Terraform configuration for provisioning the AWS backend resources used by the Calorie Lens application.

## What this project does

This repository manages AWS infrastructure for Calorie Lens using Terraform:

- Creates an S3 bucket for application assets and storage
- Deploys a CloudFront distribution with Origin Access Control (OAC)
- Stores runtime metadata in AWS Systems Manager Parameter Store
- Uses an S3 backend with DynamoDB locking for Terraform state management

## Why this is useful

- Provides a reproducible infrastructure deployment for the Calorie Lens backend
- Keeps content delivery secure with CloudFront and restricted S3 access
- Simplifies environment-specific configuration via `dev.tfvars`
- Enables safe Terraform state storage and locking in AWS

## Prerequisites

- Terraform 1.0+ installed
- AWS CLI configured with the required named profiles
- Permissions to create S3 buckets, DynamoDB tables, CloudFront distributions, and SSM parameters

## Getting started

### 1. Configure environment values

Update `dev.tfvars` to set the AWS profile and project name used for deployment.

Example:

```hcl
project_name = "calorie-lens"
aws_profile  = "serverless-user"
```

### 2. Bootstrap the Terraform backend

The `bootstrap/` workspace creates the S3 backend bucket and DynamoDB lock table used by the root project.

```bash
cd bootstrap
terraform init
terraform apply -var-file=../dev.tfvars
```

### 3. Initialize the root workspace

```bash
cd ..
terraform init
```

### 4. Plan and apply infrastructure

```bash
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

### 5. Destroy infrastructure

```bash
terraform destroy -var-file=dev.tfvars
```

## Repository structure

- `bootstrap/` – creates backend state resources (S3 + DynamoDB)
- `modules/` – reusable Terraform modules
  - `storage/` – managed S3 bucket, encryption, versioning, policy, lifecycle rules
  - `cdn/` – CloudFront distribution with origin access control
  - `secrets/` – stores bucket and CDN metadata in SSM Parameter Store
- `main.tf` – root Terraform provider and backend configuration
- `modules.tf` – module wiring and cross-module dependencies
- `variables.tf` – root-level Terraform variables
- `dev.tfvars` – local environment values for development

## Module flow

- `module.cdn` is built from the S3 bucket domain name from `module.storage`
- `module.storage` grants CloudFront access using the distribution ARN from `module.cdn`
- `module.secrets` records the bucket name and CDN URL after both modules are created

## Support

For help:

- Open an issue in this repository
- Use `TF_LOG=DEBUG` to diagnose Terraform plan/apply issues
- Validate AWS credentials with `aws sts get-caller-identity --profile <profile>`

## Contributing

Contributions are welcome. Please open issues or pull requests for module improvements, bug fixes, or documentation updates.

> If a `CONTRIBUTING.md` file exists later, follow those repository-level guidelines.

## Notes

- This repository does not include a LICENSE file at the moment.
- Keep `dev.tfvars` values accurate for each deployment environment.
