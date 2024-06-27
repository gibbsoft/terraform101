# terraform101 workshop
# Copyright (C) 2020 Nigel Gibbs
#
# This file is part of terraform101 workshop.
#
# terraform101 workshop is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# terraform101 workshop is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with terraform101 workshop.  If not, see <https://www.gnu.org/licenses/>.

module "award" {
  source   = "../step2"
  fullname = var.fullname
  project  = var.project
}

resource "aws_instance" "example-ec2-instance" {
  ami                         = data.aws_ami.ubuntu-focal.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.example.id]
  subnet_id                   = element(module.vpc.public_subnets, 0)
  associate_public_ip_address = true
  user_data                   = <<-EOF
  #!/bin/sh
  apt update
  apt upgrade -y
  apt install -y lighttpd
  echo ${module.award.content_b64} | base64 -d >/var/www/html/index.html
  systemctl enable --now lighttpd
  EOF

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    Name        = "example-ec2-instance"
    Terraform   = "true"
    Environment = "dev"
    Project     = var.project
  }
}
