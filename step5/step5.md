# Step5 - AWS example 2

## Elastic Computers?

Amazon Elastic Compute Cloud, better known as its abbreviated name EC2, is a service allowing users to fire up and manage virtual machines in the AWS public cloud.

## Web server

Whilst in the previous step we created a serverless website, this example takes the more traditional approach of building a web server to host our (very modest) content instead.

## Network Infrastructure

To host an ec2 instance, we must first define our network infrastructure that we want it to sit within on the cloud.  This is the concept of a 'Virtual Private Cloud' within the public cloud.

Many other AWS services either are compatible with, or require a VPC.  AWS provide a 'default VPC' within each region to get you up and running faster, but it is best practice not to use it.  VPCs are free, and the default limit is 5 VPCs per an account, but you can ask for more.  It's possible to 'peer' VPCs together and route traffic between them too.

We can define the network and subnets within the VPC as terraform code, then have further terraform code to manage the ec2 instance within it.

Instead of writing terraform ourselves to define our VPC, let's leverage a [vpc module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) from the _terraform registry_ to do the heavy lifting for us.

## Instance pricing

This example will create a VPC in London, or `eu-west-2` as it is known on AWS, and then spin up a single `t3.micro` sized linux instance within the VPC.

Instance pricing at the time of writing (in July 2020) for this is $0.0118 per hour, however AWS provide 750 hours free usage of this instance size within the first year of each new account.

## The aws_instance resource

In main.tf take a look at the `aws_instance` resource:

    resource "aws_instance" "example-ec2-instance" {}

:pencil: For more info on `aws_resource` see the [official docs](https://www.terraform.io/docs/providers/aws/r/instance.html)

## Make your terraform.tfvars

Copy the example tfvars file then customise it to suite your environment

    cd step5
    cp terraform.tfvars.example terraform.tfvars
    nano terraform.tfvars

## Terraform init

Tell terraform to go and register any included providers and modules.  **Note that we have to include an option to use our `terraform.tfvars` file to feed our backend-config.  We only have to do this with `init`, other terraform operations pick-up the file automatically**:

    AWS_PROFILE=<your account name> terraform init -backend-config=terraform.tfvars

## Terraform plan

:pencil: Remember, always plan before an apply or a destroy.

    AWS_PROFILE=<your account name> terraform plan

## Terraform apply

Satisfied that the plan looks reasonable?  Again, we proceed to the apply:

    AWS_PROFILE=<your account name> terraform apply

After terraform completes, it shouldn't be long before your web server is up and serving your tiny web site.  To jump onto the ec2 instance and check its system log you can run the following:

    eval $(env AWS_PROFILE=<your account name> terraform output ssh_command)
    sudo tail -f /var/log/syslog

All good?

:pencil: Try running another plan and apply.

:question: Any thoughts on security here?

## Terraform plan for destruction

:pencil: Remember, always plan before an apply or a destroy.

    AWS_PROFILE=<your account name> terraform plan -destroy

## Terraform destroy

Satisfied that the plan looks reasonable?  Again, we proceed to the apply:

    AWS_PROFILE=<your account name> terraform destroy

## Conclusion

In this step we created a cloud based webserver to host our certificate example, then blew it away.

This step also concludes the terraform101 workshop. For further reading checkout the following resources:

- [Terraform.io](terraform.io)
- [Amazon AWS Products](https://aws.amazon.com/products/)

## Cleaning UP

Remember to go back and destroy stuff you have created during the workshop, it's best to do it in reverse order, finally destroying the s3 state bucket and dynamodb table you created in step3. :warning: eventually dynamodb table allocation will start racking-up charges unless it's destroyed.

### Can't terraform destory step3? eh, why?

Before you try to destroy step3, you should empty the s3 bucket or all version of all objects otherwise terraform will refuse to delete the state bucket (for safety).

You have two options for clearing out the s3 bucket:

#### a) Manually clear out the state bucket via the GUI (beginners)

Using the AWS console GUI:

1. Login to your aws account (as root as we only have programmatic access to your IAM user)
2. Navigate to the s3 service
3. Click on your terraform state bucket to reveal its contents (`<your account name>-terraform-state`)
4. Above the list of objects in your bucket locate the option for 'Versions: Hide | Show', click on 'Show' to reveal all.
5. Select all the objects by clicking in the check box next to each.
6. With all the contents of the bucket selected, click the Actions menu, then select Delete.
7. Within the Delete Objects dialog click 'Delete', the bucket should now be empty.

#### b) Clear the bucket using a helper script (advanced)

 For the more experienced *nix user, [this script](https://gist.githubusercontent.com/weavenet/f40b09847ac17dd99d16/raw/e9fad5e2cd16f6f54446acdd79d47212f178ac6b/delete_all_object_versions.sh) can do it for you, however it requires the `awscli` python module and `jq` both installed to work, which is beyond the scope of this workshop.  That said, the workflow would be something like:

1. Install python if it is not already installed
2. Install `awscli` with pip or similar python package manager
3. Install `jq` which the script uses to parse JSON. (`apt install jq` on debian/ubuntu)
4. Download the script:

        curl -O https://gist.githubusercontent.com/weavenet/f40b09847ac17dd99d16/raw/e9fad5e2cd16f6f54446acdd79d47212f178ac6b/delete_all_object_versions.sh

5. Set the script as executable:

        chmod 755 delete_all_object_versions.sh

6. Run the script with the variables for your account:

        AWS_PROFILE=<your account name> ./delete_all_object_versions.sh <your account name>-terraform-state

Whichever of the above techniques you employed, a terraform destroy of step3 should work just fine now.

## Take off and nuke the entire site from orbit

You can close your AWS account and it will automatically blow away your creations and prevent any unexpected future bills.

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
