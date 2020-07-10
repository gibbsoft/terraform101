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

variable "bucket_name" {
  description = "The name of the AWS S3 bucket this website will be published to."
}

variable "index_file_contents_b64" {
  description = "Raw HTML to stuff into an index.html file"
  default     = "Hello World!"
}

variable "error_file_contents_b64" {
  description = "Raw HTML to stuff into an index.html file"
  default     = "Hello World!"
}
