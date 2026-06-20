# AI Agent Guide: Calorie Lens Infrastructure

## Project Overview

This is a Terraform infrastructure-as-code (IaC) project for AWS that provisions cloud resources for the **Calorie Lens** application. The project uses a modular architecture with three core modules managing storage, content delivery, and secrets.

**Key Technology Stack:**

- Terraform ~> 6.0 (AWS provider)
- AWS S3, CloudFront, Secrets Manager
- State management: S3 backend with DynamoDB locking
- Authentication: AWS profiles

---

## Architecture & Module Structure

### Root Configuration

- **main.tf**: Terraform provider and S3 backend configuration
- **modules.tf**: Module instantiation with input/output dependencies
- **variables.tf**: Root-level variables (aws_profile, project_name)
- **dev.tfvars**: Development environment variable values

### Modules

#### `modules/storage`

Creates and manages an S3 bucket for the application with:

- Public access blocking (security-first)
- Server-side encryption (AES256)
- Versioning enabled
- Lifecycle rules for cost optimization
- Integration with CloudFront via Origin Access Control

**Key Outputs:** `bucket_name`, `bucket_domain_name`

#### `modules/cdn`

Manages CloudFront distribution for content delivery:

- Origin Access Control (OAC) with S3Origin
- HTTPS redirection
- Standard caching policy (ID: `658327ea-f89d-4fab-a63d-7e88639e58f6`)
- Geo-restriction disabled

**Key Outputs:** `distribution_arn`, `cdn_url`

#### `modules/secrets`

Manages secrets (likely AWS Secrets Manager):

- Receives CDN URL and S3 bucket name as inputs
- Stores sensitive configuration

### Bootstrap

- **bootstrap/**: Contains initial Terraform state infrastructure setup
- Used to create the S3 backend bucket and DynamoDB lock table before main infrastructure
- Contains separate `main.tf`, `backend.tf`, `variables.tf`

---

## Common Terraform Workflows

### Initialize Terraform

```bash
terraform init
```

Initializes Terraform backend and downloads required providers.

### Plan Infrastructure Changes

```bash
terraform plan -var-file=dev.tfvars
```

Shows what Terraform will create/modify/destroy without applying changes.

### Apply Infrastructure

```bash
terraform apply -var-file=dev.tfvars
```

Provisions infrastructure according to configuration.

### Destroy Infrastructure

```bash
terraform destroy -var-file=dev.tfvars
```

Removes all managed infrastructure (use with caution).

### Check State

```bash
terraform state list
terraform state show [resource]
```

View current infrastructure state.

---

## Configuration & Variables

### AWS Profile

- Set via `aws_profile` variable (default in `dev.tfvars`: `serverless-user`)
- Must be configured in `~/.aws/credentials` or `~/.aws/config`
- Used for all AWS API authentication

### Project Name

- Set via `project_name` variable (default: `calorie-lens`)
- Used as prefix for all resource names to ensure uniqueness
- Example: S3 bucket named `calorie-lens-[random-suffix]`

### Environment Variable Files

- **dev.tfvars**: Development environment configuration
- Create additional `.tfvars` files for other environments (staging.tfvars, prod.tfvars)
- Load with `terraform plan -var-file=<env>.tfvars`

---

## Important Conventions

### Module File Structure

Each module follows standard Terraform structure:

- `main.tf`: Resource definitions
- `variables.tf`: Input variables with descriptions
- `outputs.tf`: Outputs for parent or other modules

### Naming Patterns

- S3 bucket: `{project_name}-{random_suffix}` (ensures AWS global uniqueness)
- CloudFront OAC: `{project_name}-oac`
- Follow snake_case for variable and resource names

### State Management

- **Backend:** S3 bucket `calorie-lens-tf-state-bucket`
- **Lock Table:** DynamoDB table `calorie-lens-tf-state-lock-table`
- **State File:** Encrypted at rest, uses lockfile to prevent concurrent modifications
- **AWS Profile:** `scoobies` (used only for backend state access)

### Security Best Practices

- S3 bucket has public access blocked (all ACLs restricted)
- Server-side encryption enabled by default
- CloudFront uses OAC (not Origin Identity) for S3 access
- HTTPS enforced via `redirect-to-https` policy
- Use AWS profiles instead of hardcoded credentials

---

## Key Files & Their Purposes

| File                | Purpose                                           |
| ------------------- | ------------------------------------------------- |
| `main.tf`           | AWS provider config, backend definition           |
| `modules.tf`        | Module declarations and inter-module dependencies |
| `variables.tf`      | Root-level input variables                        |
| `dev.tfvars`        | Development environment values                    |
| `bootstrap/main.tf` | Sets up backend infrastructure                    |

---

## Common Tasks

### Add a New AWS Resource to Storage Module

1. Edit `modules/storage/main.tf` and add resource block
2. Export as output in `modules/storage/outputs.tf` if needed by other modules
3. Run `terraform plan -var-file=dev.tfvars` to validate
4. Apply changes with `terraform apply -var-file=dev.tfvars`

### Update Module Dependencies

- Modules communicate through outputs: `module.cdn.cdn_url`, `module.storage.bucket_name`
- Always check `outputs.tf` in modules before assuming availability
- Update `modules.tf` if adding new inter-module dependencies

### Deploy Infrastructure to New Environment

1. Create `{env}.tfvars` with environment-specific values
2. Ensure AWS profile is configured in credentials
3. Run `terraform plan -var-file={env}.tfvars` for validation
4. Run `terraform apply -var-file={env}.tfvars` to deploy

---

## Debugging & Troubleshooting

### Enable Debug Logging

```bash
export TF_LOG=DEBUG
terraform plan -var-file=dev.tfvars
```

### Check AWS Profile Configuration

```bash
aws sts get-caller-identity --profile <profile-name>
```

### Inspect Actual Infrastructure State

```bash
aws s3 ls --profile <profile-name>  # List S3 buckets
aws cloudfront list-distributions --profile <profile-name>  # List CloudFront distributions
```

### Refresh State Without Changes

```bash
terraform refresh -var-file=dev.tfvars
```

---

## Related Documentation

- See [ActionDetail.md](.github/ActionDetail.md) for GitHub Actions CI/CD setup
- See [SkillDetail.md](.github/skills/SkillDetail.md) for available repository skills
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Module Best Practices](https://terraform.io/language/modules)

---

## Quick Reference

**Before making infrastructure changes:**

1. ✅ Use `terraform plan` to preview changes
2. ✅ Verify correct AWS profile is set
3. ✅ Confirm correct environment tfvars file
4. ✅ Review state lock if plan is slow

**After infrastructure changes:**

1. ✅ Document in commit message
2. ✅ Consider updating README.md for manual operations
3. ✅ Verify resources in AWS console if needed
