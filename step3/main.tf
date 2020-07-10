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

module "terraform_state_backend" {
  source                      = "git::https://github.com/cloudposse/terraform-aws-tfstate-backend.git?ref=master"
  stage                       = var.account_name
  name                        = "terraform"
  attributes                  = ["state"]
  region                      = var.region
  prevent_unencrypted_uploads = true
}
