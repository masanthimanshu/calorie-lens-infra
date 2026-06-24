This repository contains Terraform infrastructure for AWS.

Key guidance:

- Focus on Terraform files and AWS resource configuration.
- Preserve module boundaries: `bootstrap/` for backend state resources, `modules/` for reusable infrastructure.
- Use `terraform init`, `terraform validate`, and `terraform plan` before applying changes.
- Avoid creating application code; this repo is infrastructure-only.

See `AGENTS.md` for full project conventions and module guidance.
