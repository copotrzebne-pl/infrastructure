# Infrastructure

Repository to gather terraform scripts for setting up identity base infrastructure and infrastructure for apps running
in the identity aws accounts.

### AWS

aws_profile    = "copotrzebne-prod"

## Installation

```bash
brew bundle
tfenv install
tgenv install
pre-commit install
```

## How to

Go to stack which you want to deploy in directory `environemts` i.e.

```bash
terragrunt plan
terragrunt apply
terragrunt destroy
terragrunt run-all plan | apply | destroy
pre-commit run --all-files
pre-commit autoupdate
```


[GNU General Public License v3.0](LICENSE)
