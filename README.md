# Terraform 101

## Objective

The aim of this repo is to take someone who has never used Terraform before on a tour of [Terraform CLI](https://www.terraform.io/docs/cli-index.html) basics.

## Audience

Technically experienced people who just haven't gotten around to looking at Terraform yet.  An understanding of 'git' is encouraged to _unlock_ each step so that followers can see how the code builds from the ground up.  Besides, git is the de facto standard tool for source control management and is used widely to manage terraform code, so it's good to get some practice with it.

## Requirements

- Developed on Linux, but should work on MacOS or similar *nix based OS.  Terraform does also run on Windows, but one must be careful of line-endings etc.
- An Internet connection and an AWS subscription are required.
- Git is also recommended to facilitate the progression through the 'steps', although not essential as everything is right there at the head of the master branch anyway.
- A pre-created ssh keypair is required at the default name and location for step5.  You can create a one easily enough, it's documented widely, for example [here](https://git-scm.com/book/en/v2/Git-on-the-Server-Generating-Your-SSH-Public-Key).
- Optionally, pre-installation of Python and the module `awscli` could come in handy for step5.

## Version

Verified with terraform 1.0.0, although the code _should_ be compatible with later versions.

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

## Where to start?

To start with more or less nothing but this readme file and see how the project builds without being over-faced, then start here:

1. Install git, a good article for that can be found [here](https://docs.gitlab.com/ee/topics/git/how_to_install_git/).
2. Create a suitable location to hold a checkout directory and clone this git repo, starting at the tag 'step0':

        mkdir -p ~/git/gibbsoft
        cd ~/git/gibbsoft
        git clone --branch step0 https://github.com/gibbsoft/terraform101.git
        cd terraform101

3. Examine the files in the directory using your favourite text editor. Personally, I prefer [vscode](https://code.visualstudio.com/) these days, although `vi` and `nano` are often pre-installed on *nix platforms.

## So what now?

Then head over to the step1 directory and start with the [step1/README.md](step1/README.md) file.
