# Step3 - AWS primer

## What is AWS?

> Amazon Web Services (AWS) is the world’s most comprehensive and broadly adopted cloud platform, offering over 175 fully featured services
> from data centres globally. Millions of customers including the fastest-growing startups, largest enterprises, and leading government
> agencies are using AWS to lower costs, become more agile, and innovate faster. [https://aws.amazon.com/what-is-aws/]

## The AWS Terraform Provider

Terraform has a provider for AWS that enables us to create and manage the many resources offered by Amazon.  You can find the documentation for the provider and all its supported resources [here](https://www.terraform.io/docs/providers/aws/index.html).

In this section we configure _remote state and locking_ support for terraform.  In order to follow along you'll need to go and sign-up for an account.

:warning: **HUGE DISCLAIMER** Charges may apply, although if you stick with me then we should be okay on the 'free-tier'.

## Create an AWS account

If you don't have an account you can use already, then you can create an AWS account here:

https://aws.amazon.com/account/

Here's the steps involved as of June 2020:

- enter a valid email address
- set a strong 'account root' password
- give the account a short name
- address details
- card payment details (they charge $1 to verify your account)
- confirmation sms/voice call
- Pick a support plan (The 'Basic Plan' because its free!)

## Login to the AWS Console

- Click the yellow link 'Sign Into the Console' as the 'Root user', and enter your credentials.

## Activate MFA on your root account

- After login, navigate to the IAM service
- Click the 'Activate MFA on your root account' option, then 'Manage MFA'.  Proceed to configure an MFA device on your account, otherwise if your account is compromised then you'll be sorry!

## Create yourself an IAM user

It's good practice to protect and never use the 'root' account, so the first step is always to create another account for yourself.  In this case, we'll just create one for programmatically using AWS, ie. for Terraform.  This user won't be able to use the AWS Console.

- Still within the IAM service, navigate to the 'Users' menu on the left.
- Click 'Add user' and create an account for your adventures in terraform.  Be sure to check the 'Programmatic access' box to generate the key and secret that terraform will need.
- Next we want to add the new IAM user to an Admins group, but the group doesn't exist yet.  Don't worry we'll create it... click 'Create Group'.
- Enter 'Admins' as the new groups name and tick the box next to 'AdministratorAccess', then 'Create group'.
- Click 'Next: Tags'
- Click 'Next: Review'
- Click 'Create user'
- Download the .csv containing the key and secret, but keep these uber-safe because if these fall into the wrong hands you could end up with a HUGE bill.

## Configuring terraform with AWS credentials

There are a number of ways to do this, but the following method is compatible with the Python 'boto' libraries and also allows you to easily manage multiple AWS accounts with terraform without leaking creds in your shell history.

    mkdir -p ~/.aws
    nano ~/.aws/credentials

Add a section in your `~/.aws/credentials` file using the value you find in the .csv file that you downloaded from the AWS console, then save and exit the nano editor.  Follow this template as a guide:

:warning: the '<' and '>' chars should not be placed into the file!

    [<your account short name>]
    aws_access_key_id = <Your access key id>
    aws_secret_access_key = <Your secret access key>

## Review the terraform files in step3

What do these files do?  Well, I mentioned the terraform state file in step2 and I said that we would revisit it.  We need to keep our terraform state files for your AWS account safe and sound somewhere, so let's make that somewhere in AWS!  Also, to prevent terraform admins clashing with each other, terraform supports using a dynamodb database for locking.

Rather than learning how to create an s3 bucket, dynamodb table and a bunch of required IAM policies now, we can instead leverage someone else's hard work by using a module from the [Terraform Registry](https://registry.terraform.io/).  There are modules on the registry to do many-a-common task.  It's worth spending a few minutes browsing the library to get a feel for them.

Looking at `main.tf` you can see we're going to be pulling in [this module](https://registry.terraform.io/modules/cloudposse/tfstate-backend/aws/0.17.0) to do the heavy lifting.

:pencil: For more info on writing and using terraform modules see the [official docs](https://www.terraform.io/docs/modules/index.html)

## Terraform plan

I recommend you use environment variables on the CLI to tell terraform at each run which account you want to target.  That way, your code remains flexible and it should be harder to run terraform against the wrong account (a real threat if you're looking after more than one AWS account).  Additionally, you can always find the previous commands in your shell history to cut down on typing.

This time we're going to pass in another variable, so we can use it as a prefix for our s3 bucket name.  The reason we have to do this is because bucket names have to be globally unique (in the whole world).  We're going to use another method of passing in the variable to terraform, using an environment variable with the `TF_VAR_` prefix:

:pencil: Remember, always run a plan before an apply or a destroy.

    cd step3
    AWS_PROFILE=<your account name> TF_VAR_account_name=<your account name> terraform plan

Argh! It failed, why?

    │ Error: Module not installed
    │
    │   on main.tf line 19:
    │   19: module "terraform_state_backend" {
    │
    │ This module is not yet installed. Run "terraform init" to install all modules required by this configuration.

Oh yes, we forgot to do an init:

    AWS_PROFILE=<your account name> TF_VAR_account_name=<your account name> terraform init

    AWS_PROFILE=<your account name> TF_VAR_account_name=<your account name> terraform plan

Hopefully the plan returns: `Plan: 8 to add, 0 to change, 0 to destroy.`

## Terraform apply

Satisfied that the plan looks reasonable?  We proceed to the apply:

    AWS_PROFILE=<your account name> TF_VAR_account_name=<your account name> terraform apply

:pencil:  **Please don't run a terraform destroy, we build on this step later.**

## Prepare for the next step

    cd ..

Head over to [step4/README.md](/step4/README.md)

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
