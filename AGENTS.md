# AGENTS for Calorie Lens Infrastructure

This repository is a Terraform-only AWS infrastructure project for Calorie Lens.
Use this file to understand the project layout, conventions, and the narrow scope that AI agents should follow.

## Core guidance

- Primary task: manage AWS infrastructure using Terraform modules in `modules/`.
- Do not add runtime application code, frontend/backend app logic, or unrelated AWS services.
- Preserve separate module responsibilities:
  - `modules/storage` for S3 bucket resources, encryption, versioning, policies, lifecycle rules.
  - `modules/cdn` for CloudFront distribution, origin access control, and CDN wiring.
  - `modules/secrets` for storing metadata in AWS Systems Manager Parameter Store.
- Avoid hardcoding AWS credentials in Terraform files. Use configured AWS profiles instead.
- Keep changes minimal and consistent with existing project conventions.

## Common workflow

1. `cd bootstrap && terraform init && terraform apply -var-file=../dev.tfvars`
2. `cd .. && terraform init`
3. `terraform validate`
4. `terraform plan -var-file=dev.tfvars`
5. `terraform apply -var-file=dev.tfvars`

## What agents should reference

- `README.md` for onboarding, deployment commands, and repository structure.
- `CONTRIBUTING.md` for contribution workflow and review requirements.
- `main.tf`, `modules.tf`, and `variables.tf` for root workspace wiring.
- `bootstrap/` for backend state provisioning (S3 bucket + DynamoDB lock table).

## Terraform conventions

- Root variables include `aws_profile`, `project_name`, and environment-specific `*.tfvars` files.
- Module outputs should be added only when another module or the root configuration consumes them.
- Use `snake_case` consistently for variables and resource names.
- Do not change backend configuration without understanding state initialization and the bootstrap workflow.

## Safe agent behavior

- If a change affects AWS state, ensure the plan is validated with `terraform validate` and `terraform plan -var-file=dev.tfvars`.
- Avoid proposing or implementing changes that require new AWS services not already present in this repo.
- If unsure, refer to `README.md` and `CONTRIBUTING.md` rather than inventing new workflows.
