# Step1 - terraform apply

Most people like to see a "Hello World!" example when they are learning a new computer language, so who am I to disappoint.

To run it, make sure you [download](https://www.terraform.io/downloads.html) terraform and place the executable in your PATH, then:

    cd step1
    terraform apply

Type 'yes' when you are happy to unleash terraform.

Terraform has returned the outputs of the 'module', a single variable 'msg' with the contents of "Hello World!".

:pencil: More info about terraform outputs can be found in the offical docs [here](https://www.terraform.io/docs/configuration/outputs.html)

## Prepare for the next step

    cd ..

Head over to `step2/step2.md`

## License

terraform101 workshop
Copyright (C) 2020 Nigel Gibbs

This file is part of terraform101 workshop.

terraform101 workshop is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

terraform101 workshop is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with terraform101 workshop.  If not, see <https://www.gnu.org/licenses/>.
