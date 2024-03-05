data "http" "myip" {
  url = "https://ipv4.icanhazip.com/"
}

data "aws_region" "current" {}

data "aws_eip" "by_filter" {
  filter {
    name   = "tag:Name"
    values = ["CG - Elastic IP - Please don't release"]
  }
}