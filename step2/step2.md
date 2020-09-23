# Step2 - providers and resources

There are many 'providers' available, each with a bunch of 'resources' to create and manage the lifecycle of specific things.

At this stage, rather than jumping into throwing up cloud or docker infrastructure, lets take a look at one of the providers that can be used locally, the erm... `local` provider.

Hopefully this will ease you into the terraform language and capabilities without worrying about cloud accounts or further software installation just yet.

## A certificate for you

This example takes a simple template file `templates/cert.html.templ` and interpolates a few variables and issuing you a personalised certificate in the file `cert.html`.

Try this:

    cd step2
    terraform apply

:question: Oh, so that failed!?!? wtf?

## The 'local_file' resource

Mostly harmless.

> Generates a local file with the given content.

        resource "local_file" "foo" {
            content     = "foo!"
            filename = "${path.module}/foo.bar"
        }

You'll find our use of this in `main.tf`.  For more info, see the [terraform docs](https://www.terraform.io/docs/providers/local/r/file.html)

## Terraform init

That's because now that we're using terraform providers we first need to initialise the module with the following command, upon which terraform will download any providers that you have reference.  Take a look in `providers.tf` to satisfy your curiosity, then try:

    terraform init

You can see what has been downloaded by doing:

    find .terraform

## Terraform plan

Now that the module is initialised, instead of apply we should do a plan.  Always running a '**terraform plan**' first is not only good practice, **but one day might actually save your life**.  Run the following command and enter your name when prompted:

    terraform plan

Lets carefully examine the output of the plan:

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

        # local_file.cert[0] will be created
        + resource "local_file" "cert" {
            + content              = (known after apply)
            + directory_permission = "0777"
            + file_permission      = "0777"
            + filename             = "./cert.html"
            + id                   = (known after apply)
            }

    Plan: 1 to add, 0 to change, 0 to destroy.

    ------------------------------------------------------------------------

In the plan output above we can see by the `+` prefixes what things terraform has noticed do not exist on your machine, and therefore it proposes to create them for you.  The last line is of some comfort to you as it can be seen from this that nothing will be changed or destroyed (yay!).   **ALWAYS READ THIS LAST LINE OF THE PLAN CAREFULLY BEFORE RUNNING AN APPLY**

## Terraform apply

After ensuring that you have carefully checked that the terraform plan is not going to entirely destroy all of your cloud infrastructure, then we are ready to run the apply.  Be sure to open the resulting `cert.html` file in a browser to see what it has created for you.

:warning: You might need to scroll back through your terminal buffer to ensure you full appreciate the impact of the plan.

    terraform apply

Type 'yes' when you are happy to unleash terraform.

## Terraform state file

If you look closely, you'll see that terraform is keeping track of the resources it has created in the `terraform.tfstate` file.

:warning: if the terraform state file is ever lost or damaged then terraform can no longer manage the resources it created.  No biggy in our little scenario on your own machine, but it could end your career on a production network.  Take note, we will revisit this concept soon.

:question: Should you have any security concerns about the content of what you can see in the terraform state file?

## Apply without asking

I can feel that you're bound to be asking, 'how do I make it run without asking me any questions'.  Well, this will do the trick, but remember that caution must always be taken in production environments:

    terraform apply -var fullname="<Your name goes here>" -auto-approve

## Idempotent?  Nah, not here

> *adjective* - denoting an element of a set which is unchanged in value when multiplied or otherwise operated on by itself. [Google it](http://letmegooglethat.com/?q=idempotent)

Normally, terraform is for the most part _idempotent_, so running two identical applies in a row should not result in any further changes, however you'll need to cut it a break here because the `local_file` resource follows it's own rules.  Try it if you like, you will see it never gives up blowing away and recreating the same thing over and over again.

## Terraform destroy

Easy tiger! You need to be more cautious if you want to be a good terraform engineer!  We always do a plan first, like this:

    terraform plan -destroy

Then only if we are satisfied that *production* won't evaporate if we run the destroy, we proceed to:

    terraform destroy

## Step2 sample code taxonomy

By examining the files in this directory you can see how this amazing feat was achieved.  You may note:

We're starting to feel a bit more like organising our terraform code now, so by convention we store our terraform split across well-known file names, a kind of de facto standard.  Terraform doesn't really care though, because in its head it joins all the files back together anyway.  Still, it makes it easier for fellow humans to follow if all modules follow a similar pattern to this:

| File             | Description                                                                     |
| ---------------- | ------------------------------------------------------------------------------- |
| variables.tf     | Module parameters                                                               |
| locals.tf        | Local variables                                                                 |
| providers.tf     | Terraform providers                                                             |
| outputs.tf       | Module outputs                                                                  |
| main.tf          | Main part of the module                                                         |
| terraform.tfvars | values for variables, an alternative location to var CLI parameters and envvars |

- `variables.tf` defines the parameters used by this module.  It makes it easier to adopt terraform modules when this file shows what is needed to be passed in to make it work.

- `locals.tf` these variables are entirely internal to the module and are typically used to keep the rest of the code clean and avoid repetition.

- `providers.tf` a place to list the required providers to get the module up and running.  Remember we need to run `terraform init` to install these.  It is also desirable to pin each provider to specific version to ensure that the behaviour of the module is repeatable across environments.

- `outputs.tf` You can think of these as return values that the module will produce.  In this example there is nothing to consume them, so we're just one as a way to display output to the terminal... but in later examples a module may return something useful. ;)

- `main.cf` might contain key the resources of the module, but that said, developers may create resources in any .tf files they like!  Notice that we are creating a resource of type `local_file`, the documentation for that resource-type can be found [here](https://www.terraform.io/docs/providers/local/r/file.html).  On the whole, terraform's documentation is pretty good.

- `terraform.tfvars` a location to define values for variables, which override any defaults in `variables.tf`.  In fact you can have multiple `.tfvars` files and specify which ones you'd like to include using the `-var-files=` parameter.  However, the specially named `terraform.tfvars` file is auto-included if found in the current directory.

## Other providers

There are is a steadily growing list of providers to manage resources on all sorts of platforms, it's worth taking 10 minutes to have a flick through some of them, along with examples of the resources each supports.

https://www.terraform.io/docs/providers/index.html

## Prepare for the next step

    cd ..

Head over to `step3/step3.md`

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
