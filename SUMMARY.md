# Calorie Lens Infrastructure Summary

Terraform-based AWS infrastructure for the Calorie Lens project, designed to deploy secure, scalable storage and CDN delivery.

- Purpose: Provision AWS backend state resources, S3 storage, CloudFront distribution, and secrets storage using infrastructure-as-code.
- Technologies: Terraform, AWS, S3, CloudFront, DynamoDB, AWS Systems Manager Parameter Store.
- Architecture: Modular Terraform design with a dedicated `bootstrap/` backend state configuration and reusable infrastructure modules for storage, CDN, and secrets.
- Key value: Enforces secure S3 encryption, versioning, public access blocking, remote state locking, and CloudFront origin access control.
- Outcome: Simplifies deployment of production-grade AWS infrastructure while maintaining clean module separation and operational reliability.
