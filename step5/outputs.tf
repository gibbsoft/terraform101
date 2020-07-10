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

output "ec2_instance_public_dns" {
  value = "http://${aws_instance.example-ec2-instance.public_dns}"
}
output "ec2_instance_public_ips" {
  value = aws_instance.example-ec2-instance.public_ip
}
output "ssh_command" {
  value = "ssh ubuntu@${aws_instance.example-ec2-instance.public_dns}"
}
output "ec2_instance_ids" {
  value = aws_instance.example-ec2-instance.id
}
output "ec2_instance_key_name" {
  value = aws_instance.example-ec2-instance.key_name
}
output "ec2_instance_availability_zone" {
  value = aws_instance.example-ec2-instance.availability_zone
}
