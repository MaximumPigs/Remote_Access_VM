resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "firewall rules"
  vpc_id      = aws_vpc.vpc.id
}

# GENERAL

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.security_group.id
  description       = "all outbound"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_ingress_rule" "ssh_inbound_runner_ip" {
  count             = var.runner_access_enabled == true ? 1 : 0
  security_group_id = aws_security_group.security_group.id
  description       = "All Inbound from runner and my IP"
  cidr_ipv4         = "${chomp(data.http.myip.response_body)}/32"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_ingress_rule" "ssh_inbound_my_ip" {
  security_group_id = aws_security_group.security_group.id
  description       = "SSH Inbound from runner and my IP"
  from_port         = 22
  cidr_ipv4         = "${coalesce(var.my_ip, "192.168.0.1")}/32"
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "internal" {
  security_group_id = aws_security_group.security_group.id
  description       = "Internal communication between hosts"
  cidr_ipv4         = aws_subnet.subnet.cidr_block
  ip_protocol       = -1
}