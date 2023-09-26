<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->
# Terraform Beginner Bootcamp 2023 - Week 0
- [Terraform Beginner Bootcamp 2023](#terraform-beginner-bootcamp-2023)
   * [Semantic Versioning](#semantic-versioning)
   * [Install the Terraform cli](#install-the-terraform-cli)
      + [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
      + [Consideration for Linux Distribution](#consideration-for-linux-distribution)
      + [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
      + [Shebang Consideration](#shebang-consideration)
         - [Execution Consideration](#execution-consideration)
      + [Linux Permission Consideration](#linux-permission-consideration)
      + [Github Lifecycle (Before, Init, Command)](#github-lifecycle-before-init-command)
      + [Working Env Vars](#working-env-vars)
         - [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
   * [Printing Vars](#printing-vars)
         - [Scoping of Env vars](#scoping-of-env-vars)
         - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
      + [AWS CLI is installed for the project via the bash script `./bin/install_aws_cli`](#aws-cli-is-installed-for-the-project-via-the-bash-script-bininstall_aws_cli)
   * [Terraform Basics](#terraform-basics)
      + [Terraform Registry](#terraform-registry)
      + [Terraform Console](#terraform-console)
         - [Terraform init](#terraform-init)
         - [Terraform Plan](#terraform-plan)
         - [Terraform Apply](#terraform-apply)
         - [Terrafrom Destroy](#terrafrom-destroy)
      + [Terraform Lock files](#terraform-lock-files)
      + [Terraform State Files](#terraform-state-files)
      + [Terraform Directory](#terraform-directory)
      + [S3 Bucket naming policy](#s3-bucket-naming-policy)
      + [Terraform CLoud login](#terraform-cloud-login)

<!-- TOC end -->

<!-- TOC --><a name="terraform-beginner-bootcamp-2023"></a>
# Terraform Beginner Bootcamp 2023


<!-- TOC --><a name="semantic-versioning"></a>
## Semantic Versioning

This project is going to utilize semantic versioning for its taging [semver.org](https://semver.org/)

The general format:

**MAJOR.MINIOR.PATCH**, eg.  `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

<!-- TOC --><a name="install-the-terraform-cli"></a>
## Install the Terraform cli

<!-- TOC --><a name="considerations-with-the-terraform-cli-changes"></a>
### Considerations with the Terraform CLI changes
The Terraform CLI Installataion instructions have changed due to gpg keyring changes. So we needed to refer to the latest CLI insstructions via Terraform Documentation and change the scripting for install.

[Imstall Terrafrom CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)



<!-- TOC --><a name="consideration-for-linux-distribution"></a>
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

<!-- TOC --><a name="refactoring-into-bash-scripts"></a>
### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli.sh)

- This will keep the Gitpod Task File ([.gitpod.yaml](.gitpod.yaml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portablity for other projects that need to install CLI


<!-- TOC --><a name="shebang-consideration"></a>
### Shebang Consideration

A Shebang tells the bash script what program that will interpret the script. eg. `#!/usr/bin/env bash`, recommended by ChatGPT for portability for the different Linux OS distributions



https://en.wikipedia.org/wiki/Shebang_(Unix)


<!-- TOC --><a name="execution-consideration"></a>
#### Execution Consideration

When executing the bash script we can use the `./` shortend notiation to execute the bash script

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yaml, we need to point the script to a program to interpret it.

eg. `source ./bin/install_cli`

<!-- TOC --><a name="linux-permission-consideration"></a>
### Linux Permission Consideration

We need to make our Linux permission work as follow in order to make our bash script executable 

```
chmod u+x ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

<!-- TOC --><a name="github-lifecycle-before-init-command"></a>
### Github Lifecycle (Before, Init, Command)

We need to be careful when using the `Init` because it will not rerun if we restart an exisiting workspace, maybe we will need to use `before`

https://www.gitpod.io/docs/configure/workspaces/tasks

<!-- TOC --><a name="working-env-vars"></a>
### Working Env Vars

We can list out all Environment Variables (Env Vars) using the `env` command

We can filiter specific env vars using grep eg. `env | grep AWS_`

<!-- TOC --><a name="setting-and-unsetting-env-vars"></a>
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

<!-- TOC --><a name="printing-vars"></a>
## Printing Vars

We can print an env var using using echo eg. `echo $HELLO`


<!-- TOC --><a name="scoping-of-env-vars"></a>
#### Scoping of Env vars

When you open up a new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want the Env Vars to persist across all future bash terminals that are opened. You need to set the env vars in your bash profile, eg. `.bash_profile`

<!-- TOC --><a name="persisting-env-vars-in-gitpod"></a>
#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env Hello=`world`
```

All future workspaces lauched will set the env vars for all bash terminals opened in those workspaces.

You can also set the en vars in the `.gitpod.yml`, but this can only contain non-sensitive en vars.


<!-- TOC --><a name="aws-cli-is-installed-for-the-project-via-the-bash-script-bininstall_aws_cli"></a>
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

<!-- TOC --><a name="terraform-basics"></a>
## Terraform Basics

<!-- TOC --><a name="terraform-registry"></a>
### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in Terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable

<!-- TOC --><a name="terraform-console"></a>
### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform``

<!-- TOC --><a name="terraform-init"></a>
#### Terraform init

At the start of a new terraform project, we will run `terraform init` to download the binaries for the terraform providers that we'll usse in this projects.

<!-- TOC --><a name="terraform-plan"></a>
#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed

We can outpout this changeset ie. "plan" to be passed to an apply, but often you can ignore the outputting

<!-- TOC --><a name="terraform-apply"></a>
#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be execute by terrafrom. Apply should prompt yes or no

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

<!-- TOC --><a name="terrafrom-destroy"></a>
#### Terrafrom Destroy

`terraform destroy`

This will destroy our resources

You can also use the auto approve flag to skip thee approve prompt

eg. `terrafrom apply --auto-approve`

<!-- TOC --><a name="terraform-lock-files"></a>
### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

<!-- TOC --><a name="terraform-state-files"></a>
### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

<!-- TOC --><a name="terraform-directory"></a>
### Terraform Directory

`.terraform` directory contains binaries of terraform providers.



<!-- TOC --><a name="s3-bucket-naming-policy"></a>
### S3 Bucket naming policy

We have to follow the naming policy for creating the S3 bucket name

[S3 bucket naming policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)


<!-- TOC --><a name="terraform-cloud-login"></a>
### Terraform CLoud login

When attempting to run `terraform login`, press `p` to open the link to generate teh token and paste it after quit. 

Or you can manually generate a token in Terraform Cloud and create the file by pasting the token:

```sh
touch /home/gitpod/.terraform.d/credential.tfrc.json
open /home/gitpod/.terraform.d/credential.tfrc.json
```

Provided the following code (replace your token in the file)

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR_TERRAFORM_TOKEN_CODE"
    }
  }
}

```

We have automate this workaround with the following bash script [/bin/generate_tfrc_credential.sh](bin/generate_tfrc_credential.sh)

We have set the terraform alias to tf with the following script [/bin/set_tf_alias.sh](bin/set_tf_alias.sh)


https://developer.hashicorp.com/terraform/language/modules/develop/structure
