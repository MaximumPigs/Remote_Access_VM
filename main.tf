resource "aws_instance" "remote" {

  ami                         = "ami-0d6f74b9139d26bf1"
  instance_type               = "m5.large"
  key_name                    = var.key_pair
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]

  root_block_device {
    delete_on_termination = true
    volume_size           = "15"
  }

  tags = {
    "project" = var.project
  }

  credit_specification {
    cpu_credits = "standard"
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", {
    gen_key = var.pub_key,
    install_script = base64encode(file("scripts/config_vnc.sh"))
  }))
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.remote.id
  allocation_id = data.aws_eip.by_filter.id
}