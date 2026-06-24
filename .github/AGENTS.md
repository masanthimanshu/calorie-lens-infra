# AGENTS

## Project overview

This repository is a Terraform-based AWS infrastructure project.

- Root configuration uses `main.tf`, `modules.tf`, and `variables.tf`.
- `bootstrap/` contains a separate Terraform configuration for creating the remote state S3 bucket and DynamoDB lock table.
- `modules/` contains reusable modules:
  - `storage/` creates an S3 bucket with encryption, versioning, lifecycle rules, and a randomized suffix.
  - `cdn/` creates a CloudFront distribution with an Origin Access Control (OAC) and an S3 origin.
  - `secrets/` stores values in AWS SSM Parameter Store.

## Key conventions

- Preserve module boundaries. The root configuration wires modules together; changes should generally be made inside the relevant module unless global behavior must change.
- Inputs are passed through the root module; most variable names are `project_name`, `aws_profile`, `bucket_name`, and `cdn_url`.
- The `bootstrap/` module is separate from the main infrastructure and is used to provision Terraform backend resources.
- The AWS provider version is pinned to `~> 6.0`.

## Commands and workflow

- Use `terraform init` in `bootstrap/` to initialize and manage the remote state bucket / lock table resources.
- Use `terraform init` from the repository root to initialize the main infrastructure configuration.
- Use `terraform validate` and `terraform plan` before `terraform apply`.
- Required variables include `aws_profile` and `project_name`.

## What agents should do

- Focus on Terraform configuration and AWS resource definitions.
- Avoid speculative changes to provider/backend setup unless the user explicitly requests it.
- Keep naming, encryption, access control, and lock table semantics intact.
- Do not create unrelated application code; this repo is infrastructure-only.

## Notes for code generation

- When adding AWS resources, match existing conventions for S3 encryption, public access block settings, and CloudFront security posture.
- For new reusable infrastructure, prefer adding new modules under `modules/` rather than expanding root configuration directly.
- Preserve existing output names and module contracts when modifying dependencies across modules.
