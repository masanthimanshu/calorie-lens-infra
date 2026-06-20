module "storage" {
  source = "./modules/storage"

  project_name                = var.project_name
  cloudfront_distribution_arn = module.cdn.distribution_arn
}

module "cdn" {
  source = "./modules/cdn"

  project_name       = var.project_name
  bucket_domain_name = module.storage.bucket_domain_name
}

module "secrets" {
  source = "./modules/secrets"

  project_name = var.project_name
  cdn_url      = module.cdn.cdn_url
  bucket_name  = module.storage.bucket_name
}
