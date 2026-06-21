# Contributing to Calorie Lens Infrastructure

Thank you for contributing to this Terraform infrastructure repository.

## How to contribute

- Open an issue for bugs, improvements, or design questions.
- Create a pull request for changes that add or update Terraform resources, module wiring, or documentation.
- Keep changes focused and document why the change is needed.

## Recommended workflow

1. Fork or branch the repository.
2. Make your changes in a feature branch.
3. Run `terraform validate` and `terraform plan -var-file=dev.tfvars` locally.
4. Submit a pull request with a clear description of the change.

## Notes

- Do not add runtime application code or unrelated AWS services.
- Preserve module separation: `storage`, `cdn`, and `secrets`.
- Avoid hardcoding AWS credentials in Terraform files.
