# Calorie Lens Infrastructure

Terraform configuration for provisioning the AWS backend resources used by the Calorie Lens application.

## What this project does

This repository manages AWS infrastructure for Calorie Lens using Terraform.
It provisiones:

- An encrypted S3 bucket for application assets and storage
- A CloudFront distribution with Origin Access Control (OAC)
- Runtime metadata storage in AWS Systems Manager Parameter Store
- A Terraform state backend in S3 with DynamoDB locking

## Why this project is useful

- Provides reproducible infrastructure deployment for the Calorie Lens backend
- Secures content delivery with CloudFront and restricted S3 access
- Enables environment-specific configuration using `*.tfvars`
- Ensures safe Terraform state with remote backend and locking

## Prerequisites

- Terraform 1.0 or newer
- AWS CLI configured with the required named profiles
- AWS permissions to create S3 buckets, DynamoDB tables, CloudFront distributions, and SSM parameters

## Getting started

### 1. Configure environment values

Edit `dev.tfvars` to set your deployment values.

Example:

```hcl
project_name = "calorie-lens"
aws_profile  = "serverless-user"
```

### 2. Bootstrap the Terraform backend

The `bootstrap/` workspace creates the remote state bucket and DynamoDB lock table.

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

### 4. Plan infrastructure changes

```bash
terraform plan -var-file=dev.tfvars
```

### 5. Apply infrastructure

```bash
terraform apply -var-file=dev.tfvars
```

### 6. Destroy infrastructure

```bash
terraform destroy -var-file=dev.tfvars
```

## Repository structure

- `bootstrap/` — creates backend state resources (S3 + DynamoDB)
- `modules/` — reusable Terraform modules
  - `storage/` — S3 bucket, encryption, versioning, policy, lifecycle rules
  - `cdn/` — CloudFront distribution with origin access control
  - `secrets/` — writes metadata to SSM Parameter Store
- `main.tf` — root provider and backend configuration
- `modules.tf` — module wiring and dependencies
- `variables.tf` — root-level Terraform variables
- `dev.tfvars` — local environment values for development

## Module workflow

1. `module.storage` creates the S3 bucket and exposes `bucket_domain_name`
2. `module.cdn` creates the CloudFront distribution using that bucket domain name
3. `module.storage` receives the distribution ARN so CloudFront can access the bucket
4. `module.secrets` stores the bucket name and CDN URL in SSM Parameter Store

## Terraform conventions

- Provider version is pinned to `~> 6.0`
- Root variables use `aws_profile` and `project_name`
- Avoid hardcoding AWS credentials in Terraform files
- Use `snake_case` for Terraform variable and resource names
- Add module outputs only when another module or root configuration needs them

## Support

If you need help:

- Open an issue in this repository
- Use `TF_LOG=DEBUG` to troubleshoot Terraform operations
- Verify AWS credentials with `aws sts get-caller-identity --profile <profile>`

## Contributing

Contributions are welcome. Open issues or pull requests for module improvements, bug fixes, or documentation updates.

For contribution guidance, see `CONTRIBUTING.md`.

## Notes

- This repo does not include a `LICENSE` file yet.
- Create additional environment files such as `staging.tfvars` or `prod.tfvars` if needed.
