This repository is a Terraform-only AWS infrastructure project for Calorie Lens.

- Primary task: manage AWS infrastructure via Terraform modules in `modules/`.
- Do not add runtime application code, frontend/backend app logic, or unrelated AWS services.
- Use `README.md` for onboarding and deployment guidance.
- Use `AGENTS.md` for project-specific AI agent behavior and Terraform conventions.
- This file is a high-level pointer; use `AGENTS.md` for the main agent guidance and Terraform conventions.

Key workflow:

- Bootstrap backend with `cd bootstrap && terraform init && terraform apply -var-file=../dev.tfvars`
- Initialize root workspace with `terraform init`
- Validate with `terraform validate`
- Plan/apply with `terraform plan -var-file=dev.tfvars` and `terraform apply -var-file=dev.tfvars`

Important:

- Preserve separate module responsibilities: `storage`, `cdn`, `secrets`.
- Do not hardcode AWS credentials; use configured AWS profiles.
- Keep modifications minimal and consistent with existing `AGENTS.md` guidance.
