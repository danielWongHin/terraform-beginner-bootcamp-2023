# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This project is going to utilize semantic versioning for its taging [semver.org](https://semver.org/)

The general format:

**MAJOR.MINIOR.PATCH**, eg.  `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform cli

### Considerations with the Terraform CLI changes
The Terraform CLI Installataion instructions have changed due to gpg keyring changes. So we needed to refer to the latest CLI insstructions via Terraform Documentation and change the scripting for install.

[Imstall Terrafrom CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)



### Consideration for Linux Distribution

This project is built agaist Ubuntu. Please consider checking your Linux Distribution and change it accordingly to distribution needs

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli.sh)

- This will keep the Gitpod Task File ([.gitpod.yaml](.gitpod.yaml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portablity for other projects that need to install CLI


### Shebang Consideration

A Shebang tells the bash script what program that will interpret the script. eg. `#!/usr/bin/env bash`, recommended by ChatGPT for portability for the different Linux OS distributions



https://en.wikipedia.org/wiki/Shebang_(Unix)


#### Execution Consideration

When executing the bash script we can use the `./` shortend notiation to execute the bash script

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yaml, we need to point the script to a program to interpret it.

eg. `source ./bin/install_cli`

### Linux Permission Consideration

We need to make our Linux permission work as follow in order to make our bash script executable 

```
chmod u+x ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the `Init` because it will not rerun if we restart an exisiting workspace, maybe we will need to use `before`

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

We can list out all Environment Variables (Env Vars) using the `env` command

We can filiter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bash/print_message
```

Within a bash script we can set the env without writting the export

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

## Printing Vars

We can print an env var using using echo eg. `echo $HELLO`


#### Scoping of Env vars

When you open up a new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want the Env Vars to persist across all future bash terminals that are opened. You need to set the env vars in your bash profile, eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env Hello=`world`
```

All future workspaces lauched will set the env vars for all bash terminals opened in those workspaces.

You can also set the en vars in the `.gitpod.yml`, but this can only contain non-sensitive en vars.


### AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli.sh)

[Getting Started Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLi Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly  by running the following AWS Cli command:

```
aws sts get-caller-identity
```

if it is successfuly, you should see a json payload return taht look like it

```json

{
    "UserId": "BNMQETJFDD67ZN7DG65KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/testingaccount"
}
```

We will need to generate AWS CLI credits from IAM User in order to use the AWS CLI

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in Terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform``

#### Terraform init

At the start of a new terraform project, we will run `terraform init` to download the binaries for the terraform providers that we'll usse in this projects.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed

We can outpout this changeset ie. "plan" to be passed to an apply, but often you can ignore the outputting

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be execute by terrafrom. Apply should prompt yes or no

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.