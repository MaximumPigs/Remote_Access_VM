output "linux_ip" {
  value = [for instance in aws_instance.linux: instance.public_ip]
}

# output "windows_ip" {
#   value = [for instance in aws_instance.windows : instance.public_ip]
# }