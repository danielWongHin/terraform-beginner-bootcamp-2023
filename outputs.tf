output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value       = module.home_arcane_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 Static Website hossting endpoint"
  value       = module.home_arcane_hosting.website_endpoint
}

output "domain_name" {
  description = "The CloudFront Distrubtion Domain"
  value = module.home_arcane_hosting.domain_name
}
