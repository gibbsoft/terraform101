# Step4 - AWS example 1

## There's a certificate in your bucket, dear Liza

Amazon have a service called 's3', which stands for Simple Storage Services.  They provide 'buckets' that can store basically anything you want.  By default, s3 buckets are private, but it's possible to configure a policy to enable buckets to serve their contents as a web site.  The advantage of this is that there are no servers for us to have to maintain, and it's cheaper than running servers.  Terraform will output the URL of the web site for you to visit at the end of the apply.

## Make your backend.tfvars

Copy the example backend tfvars file then customise it to suite your environment

    cd step4
    cp backend.tfvars.example backend.tfvars
    nano backend.tfvars

## Terraform init

Tell terraform to go and register any included providers and modules.  **Note that we have to include an option to use our `backend.tfvars` file to feed our backend-config.  We only have to do this with `init`, other terraform operations pick-up the file automatically**:

    AWS_PROFILE=<your account name> terraform init -backend-config=backend.tfvars

## Make your terraform.tfvars

Copy the example tfvars file then customise it to suite your environment

    cd step4
    cp terraform.tfvars.example terraform.tfvars
    nano terraform.tfvars

## Terraform plan

:pencil: Remember, always plan before an apply or a destroy.

    AWS_PROFILE=<your account name> terraform plan

Hopefully the plan returns: `Plan: 3 to add, 0 to change, 0 to destroy`

## Terraform apply

Satisfied that the plan looks reasonable?  Again, we proceed to the apply:

    AWS_PROFILE=<your account name> terraform apply

Checkout your new serverless web site!

:pencil: Try running another plan and apply.

:question: Any thoughts on security here?

## Terraform plan for destruction

:pencil: Remember, always plan before an apply or a destroy.

    AWS_PROFILE=<your account name> terraform plan -destroy

Hopefully the plan returns: `Plan: 0 to add, 0 to change, 3 to destroy`

## Terraform destroy

Satisfied that the plan looks reasonable?  Again, we proceed to the apply:

    AWS_PROFILE=<your account name> terraform destroy

## Prepare for the next step

    cd ..

Head over to [step5/README.md](/step5/README.md)

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
