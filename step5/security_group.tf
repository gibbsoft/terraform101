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

resource "aws_security_group" "example" {
  name        = "${var.env}-sg-example-public"
  description = "public access"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name        = "${var.env}-sg-example"
    Environment = "${var.env}"
  }
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.example.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all"
}

resource "aws_security_group_rule" "tcp80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.example.id
  description       = "HTTP from the Internet"
}

resource "aws_security_group_rule" "tcp22" {
  count             = length(var.mgmt_whitelist)
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.mgmt_whitelist[count.index].cidr]
  security_group_id = aws_security_group.example.id
  description       = var.mgmt_whitelist[count.index].desc
}
