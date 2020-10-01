output "worker_instance_type" {
  value = var.worker.instance_type
}
output "worker_desired" {
  value = var.worker.desired
}
output "web_instance_type" {
  value = var.web.instance_type
}
output "web_desired" {
  value = var.web.desired
}
output "prefix" {
  value = var.prefix
}

output "userdata" {
  value = aws_launch_template.web.user_data
}
output "key" {
  value = aws_key_pair.katharina.key_name
}
output "clb_dns_name" {
  value       = aws_elb.web-elb.dns_name
  description = "The domain name of the load balancer"
}