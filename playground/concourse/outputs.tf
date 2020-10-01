output "key" {
  value = var.public_key
}
output "clb_dns_name" {
  value       = module.concourse.clb_dns_name   # see ../modules/concourse/outputs.tf
  description = "The domain name of the load balancer"
}